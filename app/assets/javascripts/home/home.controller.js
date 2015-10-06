; (function (angular) {
  'use strict';

  angular.module('home')
    .controller(
      'HomeController',
      [
        '$scope',
        'login',
        function ($scope, login) {
          $scope.login = login;
        }
      ]
    );

}(window.angular));