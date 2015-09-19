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
//
//= require angular/angular
//= require angular-route/angular-route
//
//= require lodash/dist/lodash
//
//= require home/home.module.js
//= require home/home.controller.js
//
//= require session/session.module.js
//= require session/session.service.js
//
//= require login/login.module.js
//= require login/login.controller.js

; (function (angular) {

  'use strict';

  angular.module(
    'wedding',
    [
      'ngRoute',
      'session',
      'home',
      'login'
    ]
  )
    .config(
      [
        '$routeProvider',
        '$locationProvider',
        function ($routeProvider, $locationProvider) {
          $routeProvider
            .when('/', {
              templateUrl: '/assets/home/home.partial.html',
              controller: 'HomeController',
              resolve: {
                guest: function ($location, SessionService) {
                  console.log('yoyoyo');
                  return SessionService
                    .isLoggedIn()
                      .then(function (response) {
                        return response.data.guest;
                      })
                      .catch(function () {
                        $location.path('/login');
                      });
                }
              }
            })
            .when('/login', {
              templateUrl: '/assets/login/login.partial.html',
              controller: 'LoginController'
            })
            .otherwise({
              redirectTo: '/'
            });
        }
      ]
    );

}(window.angular));
