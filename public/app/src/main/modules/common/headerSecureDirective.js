/**
 * Created by jrevol on 20/11/14.
 */
angular.module('caisseApp')
    .directive('headerSecure', function () {
        return {
            restrict: "E",
            scope:{
                displayLateralPanel: '=',
                displayHeaderTop:'=',
                headerTopTitle:'=',
                displayHeaderTopOpenLateralOption:'=',
                displayHeaderTopCancel:'=',
                displayHeaderTopNext:'=',
                headerTopOpenLateralOption:'&',
                headerTopCancel:'&',
                headerTopNext:'&',
                displayDecoLangButton:'=',
                changeLanguage:'&',
                changeStyle:'&',
                disconnect:'&'

            },
            templateUrl: 'modules/common/header-secure.html',
            link: function(scope) {
                scope.changeLanguageDirective = function (langue) {
                    scope.changeLanguage({key: langue});
                };
                scope.changeStyleDirective = function (stl) {
                    scope.changeStyle({style: stl});
                };
            }
        };
    }
);
