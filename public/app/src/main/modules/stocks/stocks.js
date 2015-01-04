angular.module('stocks', [])

    .config(function ($stateProvider) {
       $stateProvider
            .state('stocks', {
                url: '/',
                templateUrl: 'modules/stocks/stocks.html',
                controller: 'StocksController'
            });
    });
