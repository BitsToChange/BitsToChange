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
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require angular
//= require angular-animate
//= require angular-touch
//= require_tree .

var doFoundation = function() {
    $(document).foundation();
}

var onPageChange = function() {
    doFoundation();
    analytics.page();
}
$(document).ready(doFoundation);
$(document).on('page:load', onPageChange);
angular.module('BitsToChange', ['ngAnimate', 'ngTouch', 'btc-home'], ['$compileProvider', function ($compileProvider) {
    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|bitcoin|dogecoin|litecoin):/);
}]);