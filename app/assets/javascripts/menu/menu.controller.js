; (function (angular) {
  'use strict';

  angular.module('menu')
    .controller(
      'MenuController',
      [
        '$scope',
        'menuItems',
        'login',
        'MenuService',
        function ($scope, menuItems, login, MenuService) {
          $scope.login = login;
          $scope.menuItems = menuItems;

          $scope.menuCategories = MenuService.getAllMenuCategories();
        }
      ]
    );

}(window.angular));

