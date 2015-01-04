angular.module('caisseApp')
  .directive('slideMenu', function ($mdSidenav) {
    return {
      restrict: "E",
      templateUrl: 'modules/common/slide-menu.html',
      link: function(scope) {
        scope.toggleMenu = function() {
          $mdSidenav('menu').toggle()
        };
      }
    };
  }
);
