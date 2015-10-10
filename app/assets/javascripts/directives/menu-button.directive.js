; (function (angular) {

  'use strict';

  angular.module('directives')
    .directive('menuButton', function () {
      return {
        templateUrl: '/assets/directives/menu-button.directive.html',
        bindToController: true,
        controllerAs: 'vm',
        controller: ['$location', function ($location) {
          var self = this;

          self.goToMenu = function () {
            $location.url('/');
          };
        }]
      };
    });

}(window.angular));



