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
//= require angular-promise-extras/angular-promise-extras.js
//
//= require lodash/dist/lodash
//
//= require home/home.module.js
//= require home/home.controller.js
//
//= require rspv/rspv.module.js
//= require rspv/rspv.controller.js
//= require rspv/rspv.menu.controller.js
//= require rspv/rspv.confirm.controller.js
//
//= require session/session.module.js
//= require session/session.service.js
//
//= require login/login.module.js
//= require login/login.controller.js
//
//= require menu/menu.module.js
//= require menu/menu.service.js
//= require menu/menu.controller.js
//
//= require guests/guests.module.js
//= require guests/guests.service.js
//
//= require directives/directives.module.js
//= require directives/menu-button.directive.js
//= require directives/footer.directive.js
//= require directives/iframe-stretch.directive.js

; (function (angular) {

  'use strict';

  angular.module(
    'wedding',
    [
      'ngRoute',
      'ngPromiseExtras',
      'session',
      'home',
      'rspv',
      'login',
      'directives',
      'guests',
      'menu'
    ]
  )
    .config(
      [
        '$routeProvider',
        '$locationProvider',
        '$sceDelegateProvider',
        function ($routeProvider, $locationProvider, $sceDelegateProvider) {

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

          $sceDelegateProvider.resourceUrlWhitelist([
            'self',
            'https://www.google.com/maps/embed**'
          ]);

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
            .when('/rspv/menu', {
              templateUrl: '/assets/rspv/rspv.menu.partial.html',
              controller: 'RspvMenuController',
              resolve: {
                login: getCurrentLogin,
                comingGuests: [
                  'SessionService',
                  function (SessionService) {
                    return SessionService
                      .isLoggedIn()
                      .then(function (response) {
                        return _.select(response.data.data.login.guests, function (guest) {
                          return (guest.rspv.toLowerCase() === 'coming');
                        });
                      })
                      .catch(function () {
                        return [];
                      });
                }],
                menuItems: ['MenuService', function (MenuService) {
                  return MenuService.getAllMenuItems()
                    .then(function (response) {
                      return response.data.data.menu_items;
                    })
                    .catch(function () {
                      return [];
                    });
                }]
              }
            })
            .when('/rspv/confirm', {
              templateUrl: '/assets/rspv/rspv.confirm.partial.html',
              controller: 'RspvConfirmController',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/login', {
              templateUrl: '/assets/login/login.partial.html',
              controller: 'LoginController'
            })
            .when('/accommodation', {
              templateUrl: '/assets/partials/accommodation.partial.html',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/venue', {
              templateUrl: '/assets/partials/venue.partial.html',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/contact', {
              templateUrl: '/assets/partials/contact.partial.html',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/schedule', {
              templateUrl: '/assets/partials/schedule.partial.html',
              resolve: {
                login: getCurrentLogin
              }
            })
            .when('/menu', {
              templateUrl: '/assets/menu/menu.partial.html',
              controller: 'MenuController',
              resolve: {
                login: getCurrentLogin,
                menuItems: ['MenuService', function (MenuService) {
                  return MenuService.getAllMenuItems()
                    .then(function (response) {
                      return response.data.data.menu_items;
                    })
                    .catch(function () {
                      return [];
                    });
                }]
              }
            })
            .when('/gifts', {
              templateUrl: '/assets/partials/gifts.partial.html',
              resolve: {
                login: getCurrentLogin
              }
            })
            .otherwise({
              redirectTo: '/'
            });
        }
      ]
    );

}(window.angular));
