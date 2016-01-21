; (function (angular, _) {
  'use strict';

  angular.module('rspv')
    .controller(
      'RspvConfirmController',
      [
        '$scope',
        'login',
        function ($scope, login) {
          $scope.anyoneComing = anyoneComing;
          $scope.dayType = (
            login.is_evening_guest ?
              'evening' :
              'day'
          );

          function anyoneComing() {
            return !!_.find(login.guests, function (guest) {
              return (guest.rspv === 'coming');
            });
          }
        }
      ]
    );

}(window.angular, window._));

