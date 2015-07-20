angular.module('sale', [])

    .config(function ($stateProvider) {
       $stateProvider
            .state('sale', {
                url: '/{idContact}',
                templateUrl: 'modules/sale/sale.html',
                controller: 'SaleController'
            });
    });
