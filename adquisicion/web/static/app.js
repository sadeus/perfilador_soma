var backend = new Worker("static/worker.js");

backend.onmessage = function(e) {

  var data = e.data;

  document.getElementById("plot_img").src = 'data:image/png;base64,'+data.plot;
  var avg = Number(Math.round(data["avg_sigma"] + 'e2') + 'e-2');
  var std = Number(Math.round(data["std_sigma"] + 'e2') + 'e-2');
  document.getElementById("data").innerHTML = avg + " &plusmn; " + std;

}

function reset() {
  var request = new XMLHttpRequest();
  request.open("GET", "/sensor/reset", true);
  document.getElementById('resetBtn').setAttribute('disabled','disabled');
  request.onreadystatechange = function(){
    console.log(request.status);
    if (request.readyState == 4) {
      if (request.status == 200) {
        document.getElementById('resetBtn').removeAttribute('disabled');
      }
    }
  }
  request.send(null);
}

function download() {
  var request = new XMLHttpRequest();
  request.open("GET", "/sensor/data/raw", true);
  request.onreadystatechange = function(){
    console.log(request.status);
    if (request.readyState == 4) {
      if (request.status == 200) {
        var blob = new Blob([this.response]);
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = "raw.dat";
        link.click();
      }
    }
  }
  request.send(null);
}
