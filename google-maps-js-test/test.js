function initialize() {
  var myLatlng = new google.maps.LatLng(40.7402837,-73.9231385);
  var mapOptions = {
    zoom: 12  ,
    center: myLatlng
  };

  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);
}

google.maps.event.addDomListener(window, 'load', initialize);
