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
  function ($rootScope, $scope, $mdSidenav,$mdToast, $log,$http) {

    $scope.toggleMenu = function() {
      $mdSidenav('menu').toggle()
        .then(function(){
          $log.debug("toggle menu is done");
        });
    };

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

        $scope.addClient($scope.client).then(function (r) {
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



    /*
      TODO debugger cette merde de services !
     */
    $scope.addClient = function (client) {
      return $http({
        method: "post",
        url: "/services/client/",
        data: client
      })
        .then(function(response) {
          return response.data;
        });
    };

    $scope.getClients = function () {
      return $http({
        method: "get",
        url: "/services/client/list"
      })
        .then(function(response) {
          return response.data;
        });
    };
    /*
     TODO debugger cette merde de services qui veulent pas se mettre !
     */

    $scope.getClients().then(function (r) {
      $scope.clients = r.clients;
      console.log(r);
    });

  });
