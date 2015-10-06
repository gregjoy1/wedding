; (function (angular) {
  'use strict';

  angular.module('rspv')
    .controller(
      'RspvController',
      [
        '$scope',
        'login',
        function ($scope, login) {
          $scope.login = login;
        }
      ]
    );

}(window.angular));

