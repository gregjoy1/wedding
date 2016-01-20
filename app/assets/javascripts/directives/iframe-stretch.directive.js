; (function (angular) {

  'use strict';

  angular.module('directives')
    .directive('iFrameStretch', [
      '$window',
      function ($window) {
        return {
          templateUrl: '/assets/directives/iframe-stretch.directive.html',
          scope: {
            src: '@',
            height: '@'
          },
          link: function (scope, element) {
            var parentElement = element.parent()[0];

            updateWidth();

            $window.onresize = function () {
              scope.$apply(updateWidth);
            };

            function updateWidth() {
              scope.width = window.getComputedStyle(parentElement).width;
            }
          }
        };
      }
    ]
  );

}(window.angular));

