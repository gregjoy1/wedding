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
          $scope.formParams = {
            password: ''
          };

          $scope.login = function () {
            SessionService.login($scope.formParams.password)
              .then(function (response) {
                $location.path('/');
              })
              .catch(function () {
                alert('bad');
              });
          };
        }
      ]
    );

}(window.angular));

