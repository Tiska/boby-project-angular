angular.module('sale', [])

    .config(function ($stateProvider) {
       $stateProvider
            .state('sale', {
                url: '/',
                templateUrl: 'modules/sale/sale.html',
                controller: 'SaleController'
            });
    });
