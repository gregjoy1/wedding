; (function (angular) {
  'use strict';

  angular.module('menu')
    .controller(
      'MenuController',
      [
        '$scope',
        'menuItems',
        'login',
        function ($scope, menuItems, login) {
          $scope.login = login;
          $scope.menuItems = menuItems;

          $scope.menuCategories = MenuService.getAllMenuCategories();
        }
      ]
    );

}(window.angular));

