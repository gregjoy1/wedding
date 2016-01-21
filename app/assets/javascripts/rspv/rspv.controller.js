; (function (angular, _) {
  'use strict';

  angular.module('rspv')
    .controller(
      'RspvController',
      [
        '$scope',
        '$q',
        '$location',
        'login',
        'GuestsService',
        function ($scope, $q, $location, login, GuestsService) {
          $scope.login = login;

          $scope.beingSubmitted = false;
          $scope.guests = _.map(login.guests, mapGuest);
          $scope.canSubmitRspv = canSubmitRspv;
          $scope.submitRspv = submitRspv;

          function mapGuest(guest) {
            guest.comingBtnClass = function () {
              return {
                'panel-btn-success': (guest.rspv !== '-' && guest.rspv === 'coming')
              };
            };

            guest.notComingBtnClass = function () {
              return {
                'panel-btn-warning': (guest.rspv !== '-' && guest.rspv !== 'coming')
              };
            };

            guest.updateRspv = function (coming) {
              guest.rspv = (coming ? 'coming' : 'notcoming');
            };

            return guest;
          }

          function canSubmitRspv() {
            var canSubmit = true;

            _.each($scope.guests, function (guest) {
              if (guest.rspv === '-') {
                canSubmit = false;
              }
            });

            return canSubmit;
          }

          function submitRspv() {
            var promises = [];
            $scope.beingSubmitted = true;

            _.each($scope.guests, function (guest) {
              promises.push(GuestsService.updateGuest(guest.id, 'rspv', guest.rspv));
            });

            $q.allSettled(promises)
              .then(function (responses) {
                if (!_.contains(_.map(responses, 'state'), 'rejected')) {
                  // work out if anyones coming
                  var anyoneComing = !!_.find($scope.guests, function (guest) {
                    return (guest.rspv === 'coming');
                  });

                  var proceedToMenu = (anyoneComing && !login.is_evening_guest);

                  // send them to the right place
                  $location.url('/rspv/' + (proceedToMenu ? 'menu' : 'confirm'));
                }
              });
          }

        }
      ]
    );

}(window.angular, window._));

