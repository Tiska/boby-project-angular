angular.module('caisseApp')
    .directive('errorBanner', function () {
        return {
            restrict: "E",
            scope: {
                title: "@",
                content: '='
            },
            templateUrl: 'modules/common/error-banner.html'
        };
    }
);
