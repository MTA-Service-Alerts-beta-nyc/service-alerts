function initialize() {
  // define the coodinates to center the map on
  var myLatlng = new google.maps.LatLng(40.7402837,-73.9231385);
  // define a map id
  var MAP_ID = 'custom_style' //does this matter what it's called?

  // map settings
  var mapOptions = {
    zoom: 12,
    center: myLatlng,
    mapTypeId: MAP_ID
  };

  // var mapOptions = {
  //   zoom: 12,
  //   center: brooklyn,
  //   mapTypeControlOptions: {
  //     mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
  //   },
  //   mapTypeId: MY_MAPTYPE_ID
  // };

  // setup options for style
  var featureOpts = [
    {
      stylers: [
        { saturation: '-100' }
      ]
    }// ,
    // {
    //   elementType: 'labels',
    //   stylers: [
    //     { visibility: 'off' }
    //   ]
    // },
    // {
    //   featureType: 'water',
    //   stylers: [
    //     { color: '#890000' }
    //   ]
    // }
  ];


  // define and link up the google map
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  // setup the map styling
  var styledMapOptions = {
    name: 'Custom Style'
  }; // styled map options
  var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);
  map.mapTypes.set(MAP_ID, customMapType);


  // adding the transit later to the map
  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);
  //THIS LAYER CANNOT BE STYLED YET! DRAW LINES USING OTHER DATA INSTEAD


}

//event listener for the map to initialize it after the window loads
google.maps.event.addDomListener(window, 'load', initialize);
