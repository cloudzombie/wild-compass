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




(function ($, window) {
    
    
    $.fn.contextMenu = function (settings) {

        return this.each(function () {

            // Open context menu
            $(this).on("contextmenu", function (e) {
                //open menu
                $(settings.menuSelector)
                    .data("invokedOn", $(e.target))
                    .show()
                    .css({
                        position: "absolute",
                        left: getLeftLocation(e),
                        top: getTopLocation(e)
                    })
                    .off('click')
                    .on('click', function (e) {
                        $(this).hide();
                
                        var $invokedOn = $(this).data("invokedOn");
                        var $selectedMenu = $(e.target);
                        
                        settings.menuSelected.call(this, $invokedOn, $selectedMenu);
                });
                
                return false;
            });

            
            
            
            //make sure menu closes on any click
            $(document).click(function () {
                $(settings.menuSelector).hide();
            });
             $(document).contextmenu(function () {
                $(settings.menuSelector).hide();
            });
        });

        function getLeftLocation(e) {
            var mouseWidth = e.pageX;
            var pageWidth = $(window).width();
            var menuWidth = $(settings.menuSelector).width();
            
            // opening menu would pass the side of the page
            if (mouseWidth + menuWidth > pageWidth &&
                menuWidth < mouseWidth) {
                return mouseWidth - menuWidth;
            } 
            return mouseWidth;
        }        
        
        function getTopLocation(e) {
            var mouseHeight = e.pageY;
            var pageHeight = $(window).height();
            var menuHeight = $(settings.menuSelector).height();

            // opening menu would pass the bottom of the page
            if (mouseHeight + menuHeight > pageHeight &&
                menuHeight < mouseHeight) {
                return mouseHeight - menuHeight;
            } 
            return mouseHeight;
        }

    };
})(jQuery, window);

var contextMenuPile = [];

$('#lot-table tbody#table tr').each(function() {
    
    
            
            var currentRow = $(this);
            var userId = currentRow.attr('data-lot-id');

    
            if (-1 == contextMenuPile.indexOf(userId)) {
                
                
                
                // create a context menu with all the elements
                
                var contextMenu = document.createElement('ul');
                var id = "contextMenu_" + userId;
                contextMenu.setAttribute("id", id);
                contextMenu.style.display = 'none';
                contextMenu.className = 'dropdown-menu';
                
               
                // this part can be dynamic
                var edit_link_li = document.createElement('li');
                var edit_link = document.createElement('a');
                edit_link.appendChild(document.createTextNode('Edit'));
                edit_link.setAttribute('class','orange-link');
                edit_link.setAttribute('href','/lots/'+userId+'/edit');
                
                edit_link_li.appendChild(edit_link);
                
                var recall_link_li = document.createElement('li');                    
                var recall_link= document.createElement('a');
                recall_link.appendChild(document.createTextNode('Recall'));
                recall_link.setAttribute('class','red-link');
                recall_link.setAttribute('href','/lots/'+userId+'/recall')               
                
                recall_link_li.appendChild(recall_link);
                
                var quarantine_link_li = document.createElement('li');
                var quarantine_link = document.createElement('a');
                quarantine_link.appendChild(document.createTextNode('Quarantine'));
                quarantine_link.setAttribute('class','red-link');
                quarantine_link.setAttribute('href','/lots/'+userId+'/quarantine')
                
                quarantine_link_li.appendChild(quarantine_link);
                
                contextMenu.appendChild(edit_link_li);
                contextMenu.appendChild(recall_link_li);
                contextMenu.appendChild(quarantine_link_li);
                
                
                $('#contextMenus').append(contextMenu);
                
                $(this).contextMenu({
                    menuSelector: "#contextMenu_" + userId,
                    menuSelected: function (invokedOn, selectedMenu) {
                        var userId = invokedOn.parent().attr("data-lot-id");
                        
                        console.log(invokedOn.parent());
                    }
                });
            }
});
/*
$("#myTable td").contextMenu({
    menuSelector: "#contextMenu",
    menuSelected: function (invokedOn, selectedMenu) {
        var userId = invokedOn.parent().attr("user-id");
        var msg = "You selected the menu item '" + selectedMenu.text() +
            "' on the value '" + invokedOn.text() + "'. User id is " + userId;
        console.log(invokedOn.parent());
        alert(msg);
    }
});*/