; (function (angular) {

  'use strict';

  angular.module('session')
    .factory(
      'SessionService',
      [
        '$http',
        function ($http) {

          var _sessionApiRoute = '/api/session/';

          return {
            login: function (password) {
              return $http.post(
                _sessionApiRoute + 'login',
                {
                  password: password
                }
              );
            },

            logout: function () {
              return $http.get(_sessionApiRoute + 'logout');
            },

            isLoggedIn: function () {
              return $http.get(_sessionApiRoute);
            }
          };
        }
      ]
    );

}(window.angular));
