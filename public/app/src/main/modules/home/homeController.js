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
  function ($rootScope, $scope, $mdToast, $log,$http, ClientService,$state) {

    $scope.toastPosition = {
      bottom: false,
      top: true,
      left: true,
      right: false
    };
    $scope.getToastPosition = function() {
      return Object.keys($scope.toastPosition)
        .filter(function(pos) { return $scope.toastPosition[pos]; })
        .join(' ');
    };

    /*
     Envoir du formulaire de création de client
     */
    $scope.submitClient = function() {

      if ($scope.clientForm.$valid) {

        ClientService.addClient($scope.client).then(function (r) {
          if (r.status == 0) {
            $log.info('Création réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Création réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );
          }
          else {
            $log.info("Echec de la création");
            $scope.errorMessage = 'home.quick.errorcreate';
          }
        });

      } else {
        $log.info("Formulaire invalide !");
      }
    };

    $scope.loadClients = function(){
      ClientService.getClients().then(function (r) {
        $scope.clients = r.clients;
      });
    };

    $scope.goSales = function(){
      $state.go('sale');
    };

  });
