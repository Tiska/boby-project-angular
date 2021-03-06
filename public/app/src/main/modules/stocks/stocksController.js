'use strict';

/**
 * @ngdoc function
 * @name angularApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the angularApp
 */
angular.module('stocks')
  .controller('StocksController',
  function ($rootScope, $scope, $mdSidenav,$mdToast, $log,StocksService) {

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
     Envoir du formulaire de création de categ
     */
    $scope.submitProduitCategorie = function() {

      if ($scope.produitCategorieForm.$valid) {

        StocksService.addProduitCategorie($scope.categorieProduit).then(function (r) {
          if (r.status == 0) {
            $log.info('Création catégorie produit réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Création catégorie produit réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );
            $scope.loadProduitCategories();
            $scope.newProduitCategorie = false;
            $scope.produit = true;
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

    $scope.submitPrestationCategorie = function() {

      if ($scope.prestationCategorieForm.$valid) {

        StocksService.addPrestationCategorie($scope.categoriePrestation).then(function (r) {
          if (r.status == 0) {
            $log.info('Création catégorie prestation réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Création catégorie prestation réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );

            $scope.loadPrestationCategories();
            $scope.newPrestationCategorie = false;
            $scope.prestation = true;

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

    $scope.loadProduitCategories = function(){
      StocksService.getProduitCategories().then(function (r) {
        $scope.produitCategories = r.categories;
      });
    };

    $scope.loadPrestationCategories = function(){
      StocksService.getPrestationCategories().then(function (r) {
        $scope.prestationCategories = r.categories;
      });
    };

    $scope.loadProduits = function(){
      StocksService.getProduitsByCaregorie($scope.idProductCategorie).then(function (r) {
        $scope.produits = r.produits;
      });
    };

    $scope.loadPrestations = function(){
      StocksService.getPrestationsByCaregorie($scope.idPrestationCategorie).then(function (r) {
        $scope.prestations = r.prestations;
      });
    };

    $scope.openProductCreation = function(idProductCategorie){
      $scope.idProductCategorie = idProductCategorie;
      $scope.loadProduits();
      $scope.produit = false;
      $scope.creationProduit = true;

    };

    $scope.openPrestationCreation = function(idPrestationCategorie){
      $scope.idPrestationCategorie = idPrestationCategorie;
      $scope.loadPrestations();
      $scope.prestation = false;
      $scope.creationPrestation = true;

    };

    //création produit

    $scope.submitProduit = function() {

      if ($scope.produitForm.$valid) {
        $scope.produit.idProduitCategorie =  $scope.idProductCategorie;
        StocksService.addProduit($scope.produit).then(function (r) {
          if (r.status == 0) {
            $log.info('Création produit réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Création produit réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );

            $scope.produitForm.$pristine = false;
            $scope.loadProduits();
            $scope.newProduit = false;
            $scope.creationProduit = true;

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

    //création prestation

    $scope.submitPrestation = function() {

      if ($scope.prestationForm.$valid) {
        $scope.prestation.idPrestationCategorie =  $scope.idPrestationCategorie;
        StocksService.addPrestation($scope.prestation).then(function (r) {
          if (r.status == 0) {
            $log.info('Création prestation réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Création prestation réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );

            $scope.prestationForm.$pristine = false;
            $scope.loadPrestations();
            $scope.newPrestation = false;
            $scope.creationPrestation = true;

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

  });
