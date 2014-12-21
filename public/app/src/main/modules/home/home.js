angular.module('home', [])

    .config(function ($stateProvider) {
       $stateProvider
            .state('home', {
                url: '/',
                templateUrl: 'modules/home/home.html',
                controller: 'HomeController'
            });
    });