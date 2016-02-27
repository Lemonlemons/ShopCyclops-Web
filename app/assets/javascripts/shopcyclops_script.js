function getAddressLocation() {
  var geocoder = new google.maps.Geocoder();
  var address = "nil";
  if (document.getElementById('city').value != "" && document.getElementById('state').value != "") {
    address = document.getElementById('city').value + " , " + document.getElementById('state').value;
  }
  else if (document.getElementById('zipcode').value != "") {
    address = document.getElementById('zipcode').value;
  }
  else {
    alert("Something wrong with the inputs");
  }

  if (address != "nil") {
    geocoder.geocode( { 'address': address}, function(results, status) {

      if (status == google.maps.GeocoderStatus.OK) {
          var latitude = results[0].geometry.location.lat();
          var longitude = results[0].geometry.location.lng();
          window.location.href = "http://localhost:3000/streams?lat="+ latitude +"&lng="+ longitude;
      }
      else {
        console.log(status);
      }
    });
  }
  else {

  }

}

function getAutomaticLocation() {
  window.navigator.geolocation.getCurrentPosition(function(pos){
    console.log(pos);
    window.location.href = "http://localhost:3000/streams?lat="+ pos.coords.latitude +"&lng="+ pos.coords.longitude;
  })
}
