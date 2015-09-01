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
  function ($rootScope, $scope, $mdSidenav, $mdToast, $log, StocksService, $stateParams, ClientService, SaleService, $state) {

    ClientService.getClient($stateParams.idContact).then(function (r) {
        $scope.points = r.points;
    });

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
    $scope.addLignePanier = function(idPrestation,idProduit,libelle,prix, quantitee) {

     var q = 50;

     //cas où on a un produit
     if(quantitee != undefined){
       q = quantitee
     }

      var qTab = [];

      for (var i = 1; i <= q; i++) {
        qTab.push(i);
      }

      $scope.lignesPanier.push(
        {
          idPrestation: idPrestation,
          idProduit: idProduit,
          qTab: qTab,
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
    $scope.submitPanier = function() {

      if ($scope.produitCategorieForm.$valid) {

        var basket = {
          lignesPanier: $scope.lignesPanier,
          idClient: $stateParams.idContact
        };

        SaleService.addLignePanier(basket).then(function (r) {
          if (r.status == 0) {
            $log.info('Paiement panier réussie ! ');
            $mdToast.show(
              $mdToast.simple()
                .content('Paiement panier réussie !')
                .position($scope.getToastPosition())
                .hideDelay(800)
            );
            $state.go('home', {});
          }
          else {
            $log.info("Echec du Paiement");
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

    $scope.total=0;

    $scope.calculReduction = function(typeReduction, reduction, prix, quantitee, indexLigne){
      var prixReduit = prix * quantitee;
      if(typeReduction == 2){
        prixReduit -= reduction;
      }
      if(typeReduction == 1){
        prixReduit -= (prixReduit *(reduction/100));
      }
      $scope.lignesPanier[indexLigne].prixReduit = prixReduit;
      $scope.lignesPanier[indexLigne].typeReduction = typeReduction;

      $scope.total=0;
      $scope.lignesPanier.forEach(function(line){
        if(line.prixReduit != undefined){
          $scope.total+=line.prixReduit;
        }
      });

    }

  });
