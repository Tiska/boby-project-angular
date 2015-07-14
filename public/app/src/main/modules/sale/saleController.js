'use strict';

/**
 * @ngdoc function
 * @name angularApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the angularApp
 */
angular.module('sale')
  .controller('SaleController',
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

    //lignes de panier à mixer avec celles du back
    $scope.lignesPanier = [];

    //création d'une ligne de panier
    $scope.addLignePanier = function(idPrestation,idProduit,libelle,prix) {
      $scope.lignesPanier.push(
        {
          idPrestation: idPrestation,
          idProduit: idProduit,
          quantitee: 1,
          libelle: libelle,
          prix: prix
        }
      )
    };

    $scope.removeLine = function(index) {
      $scope.lignesPanier.splice(index, 1);
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

  });
