/**
 * Created by jrevol on 09/12/14.
 */
angular.module('caisseApp')
  .directive('scroller', function () {
    return {
      restrict: 'A',
      scope:{
        loadMore: '&'
      },
      link: function (scope, elem) {
        rawElement = elem[0]; // new
        elem.bind('scroll', function () {
          if((rawElement.scrollTop + rawElement.offsetHeight+5) >= rawElement.scrollHeight){ //new
            scope.$apply(scope.loadMore());
          }
        });
      }
    };
  });
