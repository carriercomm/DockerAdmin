
var dockerAdmin = angular.module('dockerAdmin', []);


dockerAdmin.controller('ContainerController', function($scope, $http, $timeout){

    $scope.pollingInterval = 5000;

    $scope.getStringForBinding = function(portBinding){
        return portBinding.Type + " : " + portBinding.IP + ":" + portBinding.PublicPort + " -> " + portBinding.PrivatePort;
    }

    $scope.onPollTimeout = function(){
       $http({'method': 'GET', 'url': '/containers'}).success(function(data){
           $scope.containers = data.containers;
       });

       pollTimeout = $timeout($scope.onPollTimeout, $scope.pollingInterval);
    };

    var pollTimeout = $timeout($scope.onPollTimeout, $scope.pollingInterval);

    $scope.onPollTimeout()
});
