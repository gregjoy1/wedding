; (function (angular) {

  'use strict';

  angular.module('menu')
    .factory(
      'MenuService',
      [
        '$http',
        function ($http) {

          var _menuItemsApiRoute = '/api/menu_items/';

          return {
            getAllMenuItems: function () {
              return $http.get(_menuItemsApiRoute);
            }
          };
        }
      ]
    );

}(window.angular));


