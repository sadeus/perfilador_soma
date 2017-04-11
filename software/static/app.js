
var backend = new Worker("static/worker.js");


 document.getElementById('perfilador').checked = true;
//Setea la IP desde el servidor
var request = new XMLHttpRequest();
request.open("GET", "/sensor/ip", true);
request.onreadystatechange = function(){
  if (request.readyState === 4) {
    if (request.status === 200) {
      document.getElementById('ip').value = this.response;
    }
  }
};
request.send();

function validateIP(ip) {
  if (/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(ip)) {
    return true;
  }
  return false;
}

backend.onmessage = function(e) {
  var data = e.data;
  if (data.error) {
    alert(data.error);
  } else {
    document.getElementById("plot_img").src = 'data:image/png;base64,'+data.plot;
    var avg = Number(Math.round(data["avg_sigma"] + 'e2') + 'e-2');
    var std = Number(Math.round(data["std_sigma"] + 'e2') + 'e-2');
    document.getElementById("data").innerHTML = avg + " &plusmn; " + std;
  }
}

function resetSensor() {
  var request = new XMLHttpRequest();
  request.open("POST", "/sensor/reset", true);
  request.setRequestHeader("Content-type", "application/json");
  document.getElementById('resetBtn').setAttribute('disabled','disabled');

  var ip = document.getElementById('ip').value
  sensor = document.getElementById('perfilador').checked ? 1 : 2;

  console.log(sensor);

  if (validateIP(ip)) {
    var body = {"ip": ip, "type": sensor};
    request.onreadystatechange = function(){
      if (request.readyState === 4) {
        if (request.status === 200) {
          backend.postMessage(true);
          document.getElementById('resetBtn').removeAttribute('disabled');
        }
      }
    }
    request.send(JSON.stringify(body));
  } else {
    alert("Ip inválida");
    document.getElementById('resetBtn').removeAttribute('disabled');
  }
}

function downloadRawData() {
  var request = new XMLHttpRequest();
  request.open("GET", "/sensor/data/raw", true);
  request.onreadystatechange = function(){
    console.log(request.status);
    if (request.readyState == 4) {
      if (request.status == 200) {
        var blob = new Blob([this.response]);
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = "raw.csv";
        link.click();
      }
    }
  }
  request.send(null);
}
