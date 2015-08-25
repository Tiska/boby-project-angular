'use strict';
angular.module('caisseServices').factory('ClientService',
  function($http){
    return {
      addClient: addClient,
      getClients: getClients,
      getClient: getClient
    };

    function addClient(client) {
      return $http({
        method: "post",
        url: "/services/client/",
        data: client
      })
        .then(function(response) {
            return response.data;
        });
    }

    function getClients () {
      return $http({
        method: "get",
        url: "/services/client/list"
      })
        .then(function(response) {
          return response.data;
        });
    };

    function getClient (idClient) {
      return $http({
        method: "get",
        url: "/services/client/"+idClient
      })
        .then(function(response) {
          return response.data;
        });
    };

  });
