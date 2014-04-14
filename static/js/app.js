angular.module('docker-sidebar', []).controller('SidebarController', function($scope, $http, $timeout){
    $scope.sidebarSelected = "/static/partials/containers.html";

    $scope.pollingInterval = 5000;

    $scope.onPollTimeout = function(){
       $http({'method': 'GET', 'url': '/status'}).success(function(data){
           $scope.dockerStatus = data.status;
           $scope.dockerColour = data.colour;
       });

       pollTimeout = $timeout($scope.onPollTimeout, $scope.pollingInterval);
    };

    var pollTimeout = $timeout($scope.onPollTimeout, $scope.pollingInterval);

    $scope.onPollTimeout();
});

angular.module('docker-containers', []).controller('ContainerController', function($scope, $http, $timeout){

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

    $scope.onPollTimeout();
});

angular.module('docker-images', []).controller('ImagesController', function($scope, $http, $timeout){

    $scope.refreshImageList = function(){
        $http({'method': 'GET', 'url': '/images'}).success(function(data){
           $scope.images = data.images;
       });
    };

    $scope.refreshImageList();
});

var dockerAdmin = angular.module('dockerAdmin', ['docker-containers', 'docker-images', 'docker-sidebar']);
