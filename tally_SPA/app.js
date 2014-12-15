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

});