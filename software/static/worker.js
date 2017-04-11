
function makeRequest(method, url, success, error) {
  var xhr = new XMLHttpRequest();
  xhr.open(method, url);
  xhr.onreadystatechange = function(){
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        success(xhr.response);
      } else {
        error(xhr.response);
      }
    }
  }
  xhr.send();
}

function timeout() {
    setTimeout(makeRequest('GET', "/sensor/data", function(res) {
        var data = JSON.parse(res);
        self.postMessage(data);
        timeout();
      }, function (err) {
        self.postMessage({"error": err});
      }), 2000);
}

timeout();

onmessage = function(e) {
  var restart = e.data;
  if (restart) {
    timeout();
  }
}
