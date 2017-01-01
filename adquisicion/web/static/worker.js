setInterval(function(){
  var request = new XMLHttpRequest();
  request.open('GET', "/sensor/data");
  request.onreadystatechange = function() {
    // Makes sure the document is ready to parse.
    if(request.readyState == 4) {
      // Makes sure it's found the file.
      if(request.status == 200) {
        var data = JSON.parse(this.response);
        self.postMessage(data);
      }
    }
  };
  request.send(null);

}, 2000);
