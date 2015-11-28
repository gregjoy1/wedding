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
            },
            getAllMenuCategories: function () {
              return [
                {
                  name: 'starter',
                  title: 'Starter'
                },
                {
                  name: 'main',
                  title: 'Main'
                },
                {
                  name: 'desert',
                  title: 'Desert'
                }
              ];
            }
          };
        }
      ]
    );

}(window.angular));


