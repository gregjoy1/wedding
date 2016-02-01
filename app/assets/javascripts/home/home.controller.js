; (function (angular) {
  'use strict';

  angular.module('home')
    .controller(
      'HomeController',
      [
        '$scope',
        '$location',
        'login',
        function ($scope, $location, login) {
          $scope.login = login;

          var pages = [
            {
              classString: 'col-xs-12 margin-bottom-md',
              faClass: 'fa-check-square-o',
              title: 'Please RSPV',
              subtitle: 'Please complete by June 2016',
              go: function () {
                $location.url('/rspv');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              title: 'Accommodation',
              faClass: 'fa-bed',
              go: function () {
                $location.url('/accommodation');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              faClass: 'fa-map-marker',
              title: 'Venue',
              go: function () {
                $location.url('/venue');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              faClass: 'fa-phone',
              title: 'Contact',
              go: function () {
                $location.url('/contact');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              faClass: 'fa-clock-o',
              title: 'Schedule',
              go: function () {
                $location.url('/schedule');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              faClass: 'fa-cutlery',
              title: 'Menu',
              go: function () {
                $location.url('/menu');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              faClass: 'fa-gift',
              title: 'Gifts',
              go: function () {
                $location.url('/gifts');
              }
            }
          ];

          $scope.pages = _.reject(pages, function (page) {
            return (login.is_evening_guest && page.title === 'Menu');
          });
        }
      ]
    );

}(window.angular));
