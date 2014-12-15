$(document).ready(function() {
  //render handlebars template
  var compile_template = function(id, data) {
    var source   = $(id).html();
    var template = Handlebars.compile(source);
    var html = template({postData: data});
    $("#container").html(html);
  };

  //set up users collection
  var Users = Backbone.Collection.extend({
    url: "/users"
  });

  var users = new Users();

  //set up user model
  var User = Backbone.Model.extend({
    urlRoot: "/users"
  });

  var users = new Users();

  //set up events collection
  var Events = Backbone.collection.extend({
    url: ""
  });

  //set up events model
  var Event = Backbone.Model.extend({
    urlRoot: ""
  });

  var events = new Events();

  //set up post list view
  var AllEvents = Backbone.View.extend({
    el: "#container",

    render: function() {
      events.fetch({
        success: function() {
          compile_template("#event-feed", events.models);
        }
      });
    }
  });

   Backbone.history.start();

});