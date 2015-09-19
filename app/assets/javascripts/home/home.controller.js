; (function (angular) {
  'use strict';

  angular.module('home')
    .controller(
      'HomeController',
      [
        '$scope',
        function ($scope) {
          console.log('loaded HomeController');
        }
      ]
    );

}(window.angular));
