; (function (angular, _) {
  'use strict';

  angular.module('rspv')
    .controller(
      'RspvMenuController',
      [
        '$scope',
        '$q',
        '$location',
        'menuItems',
        'comingGuests',
        'login',
        'GuestsService',
        'MenuService',
        function ($scope, $q, $location, menuItems, comingGuests, login, GuestsService, MenuService) {
          $scope.selectingMenuFor;
          $scope.beingSubmitted = false;

          $scope.login = login;
          $scope.menuItems = menuItems;
          $scope.comingGuests = comingGuests;

          $scope.selectMenuFor = selectMenuFor;
          $scope.selectMenuItemFor = selectMenuItemFor;
          $scope.isMenuItemSelectedForGuest = isMenuItemSelectedForGuest;
          $scope.confirmMenuItems = confirmMenuItems;
          $scope.hasMenuBeenDecidedFor = hasMenuBeenDecidedFor;
          $scope.hasMenuBeenDecidedForAllGuests = hasMenuBeenDecidedForAllGuests;
          $scope.finish = finishChoosingMenuItems;

          $scope.menuCategories = MenuService.getAllMenuCategories();

          function finishChoosingMenuItems() {
            $location.url('/rspv/confirm');
          }

          function hasMenuBeenDecidedForAllGuests() {
            return !_.find($scope.comingGuests, function (guest) {
              return (hasMenuBeenDecidedFor(guest) === false);
            });
          }

          function hasMenuBeenDecidedFor(guest) {
            return !_.find(guest.meal_choices, function (mealChoice) {
              // if there are no meal choices at all
              return !mealChoice.length;
            });
          }

          function selectMenuFor(guest) {
            $scope.selectingMenuFor = (
              angular.isDefined(guest) ?
                guest :
                undefined
            );
          }

          function selectMenuItemFor(menuItem, category) {
            $scope.selectingMenuFor.meal_choices[category.name] = [menuItem];
          }

          function isMenuItemSelectedForGuest(menuItem, category) {
            if (!$scope.selectingMenuFor.meal_choices[category.name].length) {
              return false;
            }

            return ($scope.selectingMenuFor.meal_choices[category.name][0].id === menuItem.id);
          }

          function confirmMenuItems() {
            var guest = $scope.selectingMenuFor;

            var chosenMenuItems = _.map(guest.meal_choices, function (category) {
              return {
                id: category[0].id
              };
            });

            GuestsService.updateGuest(guest.id, 'menu_items', chosenMenuItems)
              .then(function (response) {
                $scope.selectMenuFor();
              })
              .catch(function (error) {
                console.log('TODO, sort this!!');
              });
          }

        }
      ]
    );

}(window.angular, window._));


