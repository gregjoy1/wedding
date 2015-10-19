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

          console.log($scope.menuItems);
        }
      ]
    );

}(window.angular));

