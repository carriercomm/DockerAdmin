<html ng-app="dockerAdmin">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="static/css/bootstrap.css"  type="text/css"/>
    <link href="static/css/admin.css" rel="stylesheet">

    <script src="static/js/jquery-1.11.0.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.js"></script>
    <script src="static/js/app.js"></script>

    <title>Docker Admin</title>
</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <span class="navbar-brand docker-title">Docker-Admin</span>
    </div>
  </div>
</div>

<div class="container-fluid" ng-controller="SidebarController">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li ng-class="{active: sidebarSelected == '/static/partials/containers.html'}"><a href="javascript:void(0);" ng-click="sidebarSelected = '/static/partials/containers.html'">Containers</a></li>
            <li ng-class="{active: sidebarSelected == '/static/partials/images.html'}"><a href="javascript:void(0);" ng-click="sidebarSelected = '/static/partials/images.html'">Images</a></li>
          </ul>
        </div>
      </div>



      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header" style="color: {{ dockerColour }}">Status: {{ dockerStatus }}</h1>
          <div ng-include="sidebarSelected"></div>
      </div>
</body>
</html>
