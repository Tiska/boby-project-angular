'use strict';
angular.module('caisseServices').factory('SaleService',
  function($http){
    return {
      addLignePanier: addLignePanier
    };

    function addLignePanier(panier) {
      return $http({
        method: "post",
        url: "/services/panier",
        data: panier
      })
        .then(function(response) {
            return response.data;
        });
    }

  });
