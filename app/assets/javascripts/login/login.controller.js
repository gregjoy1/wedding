; (function (angular) {
  'use strict';

  angular.module('login')
    .controller(
      'LoginController',
      [
        '$scope',
        '$location',
        'SessionService',
        function ($scope, $location, SessionService) {
          $scope.showError = false;

          $scope.formParams = {
            password: ''
          };

          $scope.getLoginFormClass = function () {
            return {
              'has-error': $scope.showError
            };
          };

          $scope.login = function () {
            SessionService.login($scope.formParams.password)
              .then(function (response) {
                $location.path('/');
              })
              .catch(function () {
                $scope.showError = true;
              });
          };
        }
      ]
    );

}(window.angular));

