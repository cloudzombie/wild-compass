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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/core
//= require turbolinks
//= require bootstrap
//= require admin-lte
//= require jspdf
//= require jspdf.plugin.addimage
//= require jspdf.plugin.png_support
//= require png
//= require zlib
//= require filesaver
//= require_tree 

//Ajax Tables
$(function() {
	$(document).on("click","#sort th a", function() {
		$.getScript(this.href);
		return false;
	});
	$("#search_form input").keyup(function() {
		$.get($("#search_form").attr("action"), $("#search_form").serialize(), null, "script");
		return false;
	});
});


