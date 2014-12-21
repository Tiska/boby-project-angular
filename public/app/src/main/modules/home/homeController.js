'use strict';

/**
 * @ngdoc function
 * @name angularApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the angularApp
 */
angular.module('home')
  .controller('HomeController',
  function ($rootScope, $scope, $mdSidenav, $log) {

    $scope.toggleLeft = function() {
      $mdSidenav('left').toggle()
        .then(function(){
          $log.debug("toggle left is done");
        });
    };
  });
