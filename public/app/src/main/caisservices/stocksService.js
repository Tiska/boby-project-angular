'use strict';
angular.module('caisseServices').factory('StocksService',
  function($http){
    return {
      addProduitCategorie: addProduitCategorie,
      getProduitCategories: getProduitCategories,
      addPrestationCategorie: addPrestationCategorie,
      getPrestationCategories: getPrestationCategories,
      getProduitsByCaregorie: getProduitsByCaregorie,
      addProduit: addProduit,
      addPrestation: addPrestation,
      getPrestationsByCaregorie: getPrestationsByCaregorie
    };

    function addProduitCategorie(categorie) {
      return $http({
        method: "post",
        url: "/services/produit/categorie/",
        data: categorie
      })
        .then(function(response) {
          return response.data;
        });
    }

    function getProduitCategories () {
      return $http({
        method: "get",
        url: "/services/produit/categorie/list"
      })
        .then(function(response) {
          return response.data;
        });
    };

    function getProduitsByCaregorie (idCategorieProduit) {
      return $http({
        method: "get",
        url: "/services/produit/list/byCategorie/"+idCategorieProduit
      })
        .then(function(response) {
          return response.data;
        });
    };

    function getPrestationsByCaregorie (idCategoriePrestation) {
      return $http({
        method: "get",
        url: "/services/prestation/list/byCategorie/"+idCategoriePrestation
      })
        .then(function(response) {
          return response.data;
        });
    };

    function addPrestationCategorie(categorie) {
      return $http({
        method: "post",
        url: "/services/prestation/categorie/",
        data: categorie
      })
        .then(function(response) {
          return response.data;
        });
    }

    function addProduit(produit) {
      return $http({
        method: "post",
        url: "/services/produit/",
        data: produit
      })
        .then(function(response) {
          return response.data;
        });
    }

    function getPrestationCategories () {
      return $http({
        method: "get",
        url: "/services/prestation/categorie/list"
      })
        .then(function(response) {
          return response.data;
        });
    };

    function addPrestation(prestation) {
      return $http({
        method: "post",
        url: "/services/prestation/",
        data: prestation
      })
        .then(function(response) {
          return response.data;
        });
    }

  });
