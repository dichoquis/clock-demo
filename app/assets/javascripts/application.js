// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require materialize/extras/nouislider
//= require global
//= require time_sheets

$(document).ajaxError(function (event, request, settings) {
    if (request.status == 401) // Unauthorized
        location.reload(true);
    else if (request.status == 400) // Bad Request
        location.reload(true);
});
