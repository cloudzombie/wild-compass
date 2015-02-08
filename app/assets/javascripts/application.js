// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require turbolinks
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery.turbolinks
//= require bootstrap
//= require adminlte/app
//= require wild_compass
//= require jspdf
//= require jspdf.plugin.addimage
//= require jspdf.plugin.png_support
//= require png
//= require zlib
//= require filesaver
//= require_tree .
//= require_self
//= require select2

(function($, undefined) {
  $(function() {
    var $body = $("body")
    var controller = $body.data("controller").replace(/\//g, "_");
    var action = $body.data("action");

    var activeController = WildCompass[controller];

    if (activeController !== undefined) {
      if ($.isFunction(activeController.init)) {
        activeController.init();
      }

      if ($.isFunction(activeController[action])) {
        activeController[action]();
      }
    }
  });
})(jQuery);

$(document).ready(function() {
  $("input:text").attr("autocomplete", "off");
});