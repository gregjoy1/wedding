; (function (angular) {

  'use strict';

  angular.module('guests')
    .factory(
      'GuestsService',
      [
        '$http',
        function ($http) {

          var _sessionApiRoute = '/api/guests/';

          return {
            updateGuest: function (id, field, value) {
              var updatedAttribute = {};
              updatedAttribute[field] = value;

              return $http.put(_sessionApiRoute + id, updatedAttribute);
            }
          };
        }
      ]
    );

}(window.angular));

