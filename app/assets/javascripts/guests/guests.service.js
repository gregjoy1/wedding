; (function (angular, _) {

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
              var updatedAttributes = field;

              if (!_.isObject(field)) {
                updatedAttributes = {};
                updatedAttributes[field] = value;
              }

              return $http.put(_sessionApiRoute + id, updatedAttributes);
            }
          };
        }
      ]
    );

}(window.angular, window._));

