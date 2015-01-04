'use strict';
angular.module('caisseServices').factory('ClientService',
  function($http){
    return {
      addClient: addClient
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

  });
