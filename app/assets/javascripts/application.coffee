#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery-ui/core
#= require jquery-tablesorter
#= require foundation
#= require turbolinks
#= require handlebars
#= require ember
#= require ember-data
#= require active-model-adapter
#= require jspdf
#= require jspdf.plugin.addimage
#= require jspdf.plugin.png_support
#= require png
#= require zlib
#= require filesaver
#= require select2
#= require_self
#= require wild_compass

# Foundation
$ -> $(document).foundation()

# Ember
window.WildCompass = Ember.Application.create()
