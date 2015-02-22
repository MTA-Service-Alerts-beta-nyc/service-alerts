var MTA = MTA || { Models: {}, Collections: {} }; //, Views: {} };


//Models

MTA.Models.Alert = Backbone.Model.extend({
  // expecting:
  // lines affected
  // station if applicable
  // alert type if applicable
  // alert text
}); //MTA Model Alert

MTA.Models.Station = Backbone.Model.extend({
  // expecting:
  // name
  // lines associated with the specific station
  // longitude and lattitude
}); //MTA Model Alert

//Collections

//How can I account for asking for a range of alerts
//without loading the entire alert history into the browser?
//need API params, can just load with an ajax call instead if needed.
MTA.Collections.Alerts = Backbone.Collection.extend({
  model: ContactList.Models.Alert,
  url: 'api for the alerts' //may need to add a param for date time?
});

MTA.Collections.Stations = Backbone.Collection.extend({
  model: ContactList.Models.Station,
  url: 'api for the stations'
});

//things
