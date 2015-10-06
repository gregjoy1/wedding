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
//= require rspv/rspv.module.js
//= require rspv/rspv.controller.js
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
      'rspv',
      'login'
    ]
  )
    .config(
      [
        '$routeProvider',
        '$locationProvider',
        function ($routeProvider, $locationProvider) {

          var getCurrentLogin = [
            '$location',
            'SessionService',
            function ($location, SessionService) {
              return SessionService
                .isLoggedIn()
                  .then(function (response) {
                    return response.data.data.login;
                  })
                  .catch(function () {
                    $location.path('/login');
                  });
            }
          ];

          $routeProvider
            .when('/', {
              templateUrl: '/assets/home/home.partial.html',
              controller: 'HomeController',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/rspv', {
              templateUrl: '/assets/rspv/rspv.partial.html',
              controller: 'RspvController',
              resolve: {
                login: getCurrentLogin
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
