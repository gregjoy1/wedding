; (function (angular, _) {
  'use strict';

  angular.module('rspv')
    .controller(
      'RspvConfirmController',
      [
        '$scope',
        '$location',
        'login',
        function ($scope, $location, login) {
          $scope.anyoneComing = anyoneComing;

          function anyoneComing() {
            return !!_.find(login.guests, function (guest) {
              return (guest.rspv === 'coming');
            });
          }
        }
      ]
    );

}(window.angular, window._));

