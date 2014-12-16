// $(document).ready(function() {
  // render handlebars template
  var compile_template = function(id, data) {
    var source   = $(id).html(),
    template = Handlebars.compile(source),
    html = template({Data: data});
    $("#container").html(html);
  };

  //set up the routes
  var Router = Backbone.Router.extend({
    routes: {
      "login":"login",
      "signup":"signup",
      "account":"account",
      "settings":"settings",
      "pol/:id":"pol_view",
      "home":"index",
      "*action":"redirect"
    }
  });

  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader("Accept", "application/json")
    }
  });

  var router = new Router();

  var root_uri = "https://tally-us.herokuapp.com"

  //set up pols collection
  var Pols = Backbone.Collection.extend({
    url: root_uri + "/events"
  });

  //set up pol model
  var Pol = Backbone.Model.extend({
    urlRoot: root_uri + "/pols"
  });

  var pols = new Pols();

  //set up users collection
  var Users = Backbone.Collection.extend({
    url: root_uri + "/users"
  });

  //set up user model
  var User = Backbone.Model.extend({
    urlRoot: root_uri + "/users"
  });

  var users = new Users();

  //set up events collection
  var Events = Backbone.Collection.extend({
    url: root_uri + "/events"
  });

  //set up events model
  var Event = Backbone.Model.extend({
    urlRoot: root_uri + "/events"
  });

  var events = new Events();

  //set up post list view
  var AllPols = Backbone.View.extend({
    el: "#container",

    render: function() {
      // $.ajax({
      //   url: "https://congress.api.sunlightfoundation.com/legislators/locate?apikey=df81c6bfa0d64dd684ce4ca0435af8f8&latitude=42.96&longitude=-108.09",
      //   type: "GET",
      //   success: function(data) { 
      //       var source = $("#event-feed").html();

      //       var template = Handlebars.compile(source);

      //       var html = template({Data: data});

      //       $("#container").html(html);
      //   },
      //   error: function(jqXHR, textStatus, errorThrown) { 
      //           alert("something went wrong getting lat lng pols");
      //           console.log(errorThrown);
      //       }
      //   });
      pols.fetch({
        success: function() {
          compile_template("#event-feed", pols.models);
          console.log(pols.models)
        }
      });
    }
  });

  Handlebars.registerHelper('ifCond', function(v1, v2, options) {
    if(v1 === v2) {
      return options.fn(this);
    }
    return options.inverse(this);
  }); 

  //set up post list view
  var AllPol = Backbone.View.extend({
    el: "#container",

    render: function(id) {
      var pol = new Pol({
        id:id 
      })
      pol.fetch({
        success: function() {
          compile_template("#pol-scoreboard", pol.attributes);
          console.log(pol.attributes)
        }
      });
    }
  });

  router.on("route:pol_view", function(id) {
    // Need Pols events here
    var allpol = new AllPol()
    allpol.render(id)
  });

  router.on("route:redirect", function() {
    router.navigate("home")
  });

  router.on("route:index", function() {
    var allpols = new AllPols()
    allpols.render()
    // Need Pols events here
  });

  Backbone.history.start();

// });