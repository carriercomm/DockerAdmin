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

<div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Containers</a></li>
            <li><a href="#">Images</a></li>
          </ul>
        </div>
      </div>

      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header" style="color: ${statusColour}">Status: ${status}</h1>
            <div class="table-responsive" ng-controller="ContainerController">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Image</th>
                      <th>Command</th>
                      <th>Created</th>
                      <th>Status</th>
                      <th>Ports</th>
                      <th>Names</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr ng-repeat="container in containers">
                      <td>{{ container.Id }}</td>
                      <td>{{ container.Image }}</td>
                      <td>{{ container.Command }}</td>
                      <td>{{ container.Created }}</td>
                      <td>{{ container.Status }}</td>
                      <td>
                          <p ng-repeat="portBinding in container.Ports">{{ getStringForBinding(portBinding) }}</p>
                      </td>
                      <td>
                          <p ng-repeat="name in container.Names">{{ name }}</p>
                      </td>
                    </tr>
                  </tbody>
                </table>
            </div>
        </div>
      </div>
</body>
</html>
