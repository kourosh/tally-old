// $(document).ready(function() {
  // render handlebars template
  var compile_template = function($template_el, $container_el, data) {
    var source   = $template_el.html(),
        template = Handlebars.compile(source),
        html     = template({Data: data});

    $container_el.html(html);
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
      "logout":"logout",
      "*action":"redirect"
    }
  });

  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader("Accept", "application/json")
    }
  });

  var router = new Router();

  var root_uri = "http://tally-us.herokuapp.com/api"

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
    el: "#event-feed-container",

    render: function() {
      var that = this;
      pols.fetch({
        success: function() {
          compile_template($("#event-feed"), that.$el, pols.models);
          console.log(pols.models)
        }
      });
    },
    events: {
      "click .support":"support",
      "click .oppose":"oppose"
    },
    support: function(event) {
      var that = this;
      var eid = event.target.id
      var uid = sessionStorage.getItem("user_id")
      $.ajax({
        url: root_uri + "/support",
        type: "POST",
        data: {
          uid: uid,
          eid: eid
        },
        success: function() { 
          window.location.href = "#home"
          that.undelegateEvents();
        },
        error: function(jqXHR, textStatus, errorThrown) {
          $("#create-account-modal").modal("show");
          that.undelegateEvents();
          console.log(errorThrown);
        }
      });
    },
    oppose: function(event) {
      var that = this;
      var eid = event.target.id
      var uid = sessionStorage.getItem("user_id")
      $.ajax({
        url: root_uri + "/oppose",
        type: "POST",
        data: {
          uid: uid,
          eid: eid
        },
        success: function() { 
          window.location.href = "#home"
          that.undelegateEvents();
        },
        error: function(jqXHR, textStatus, errorThrown) {
          $("#create-account-modal").modal("show");
          that.undelegateEvents();
          console.log(errorThrown);
        }
      });
    }
  });

  var LocalPols = Backbone.View.extend({
    el: "#local-pol-container",

    render: function() {
      var that = this;
      $.ajax({
        url: "https://congress.api.sunlightfoundation.com/legislators/locate?apikey=df81c6bfa0d64dd684ce4ca0435af8f8&latitude="+sessionStorage.getItem("lat")+"&longitude="+sessionStorage.getItem("lng"),
        type: "GET",
        success: function(data) {
          compile_template($("#local-politicians"), that.$el, data.results);
        },
        error: function(jqXHR, textStatus, errorThrown) { 
                alert("something went wrong getting lat lng pols");
            }
        });
    }
  });

  var UserBalance = Backbone.View.extend({
    el: "#users-balance",

    render: function(id) {
      var that = this;
      var user = new User({
        id: id
      })
      user.fetch({
        success: function(data) {
          compile_template($("#user-balance"), that.$el, data);
        }
      })
    }
  })

  Handlebars.registerHelper('ifCond', function(v1, v2, options) {
    if(v1 === v2) {
      return options.fn(this);
    }
    return options.inverse(this);
  }); 

  //set up post list view
  var AllPol = Backbone.View.extend({
    el: "#pol_view",

    render: function(id) {
      var that = this;
      var pol = new Pol({
        id:id 
      })
      pol.fetch({
        success: function() {
          compile_template($("#pol-scoreboard"),that.$el, pol.attributes);
          $("#event-feed-container").html("");
          $("#users-balance").html("");
          $("#local-pol-container").html("");

          
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
    window.location.href = "#home"
  });

  router.on("route:logout", function() {
    sessionStorage.removeItem("auth_token");
    sessionStorage.removeItem("user_id");
    sessionStorage.removeItem("lat");
    sessionStorage.removeItem("lng");
    window.location.href = "#home"
  });

  router.on("route:index", function() {
    if (!sessionStorage.getItem("auth_token")) {
      $('.not-signedin').show();
      $('.signedin').hide();
    } else {
      $('.not-signedin').hide();
      $('.signedin').show();
    }
    var allpols = new AllPols();
    allpols.render();
    var userbalance = new UserBalance();
    userbalance.render(sessionStorage.getItem("user_id"));
    var localpols = new LocalPols();
    localpols.render();
    $("#pol_view").html("");
    // Need Pols events here
  });

  Backbone.history.start();

  getEmploymentStatus = function() {
    if ($("#add-unemployed-or-retired").is(':checked')) {
      return 1;
    } else {
      return 0;
    }
  };

  $(document).on("click", "#signup", function(){
      $.ajax({
        url: root_uri + "/users",
        type: "POST",
        data: {
          user: {
            email: $("#add-email").val(),
            user_first_name: $("#add-firstname").val(),
            user_last_name: $("#add-lastname").val(),
            user_street_address: $("#add-street").val(),
            user_city: $("#add-city").val(),
            user_state: $("#add-state").val(),
            user_zip: $("#add-zip").val(),
            user_phone: $("#add-phone").val(),
            occupation: $("#add-position").val(),
            employer_name: $("#add-eployer").val(),
            unemployed_or_retired: getEmploymentStatus(),
            password: $("#add-password").val()
          }
        },
        success: function(data){
          console.log(data);
          $("#create-account-modal").modal("hide");
          sessionStorage.setItem("auth_token", data.auth_token);
          sessionStorage.setItem("user_id", data.id);
          sessionStorage.setItem("lat", data.latitude);
          sessionStorage.setItem("lng", data.longitude);
          window.location.href = ""
        },
        error: function() {
          alert("Something went wrong adding a user");
        }
      });
    });

   $(document).on("click", "#login", function(){
      $.ajax({
        url: root_uri + "/users/login",
        type: "POST",
        data: {
          user: {
            email: $("#check-email").val(),
            password: $("#check-password").val()
          }
        },
        success: function(user){
          console.log(user);
          $("#login-modal").modal("hide");
          sessionStorage.setItem("auth_token", user.auth_token);
          sessionStorage.setItem("user_id", user.id);
          sessionStorage.setItem("lat", user.latitude);
          sessionStorage.setItem("lng", user.longitude);
          window.location.href = ""
        },
        error: function() {
          alert("Something went wrong signing in");
        }
      });
    });

   $(document).on("click", "#switch-modal", function(){
      $("#create-account-modal").modal("hide");
      $("#login-modal").modal("show");
    });

// });