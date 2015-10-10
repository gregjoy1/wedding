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
          $scope.pages = [
            {
              classString: 'col-xs-12 margin-bottom-md',
              faClass: 'fa-check-square-o',
              title: 'Please RSPV',
              go: function () {
                $location.url('/rspv');
              }
            },
            {
              classString: 'col-xs-12 col-sm-6 margin-bottom-md',
              title: 'Accomodation',
              faClass: 'fa-bed',
              go: function () {
                $location.url('/accomodation');
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
        }
      ]
    );

}(window.angular));
