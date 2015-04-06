# AngularJSの設定ファイル
# 依存ライブラリを記述
app = angular.module('sampleApp', ['ui.bootstrap', 'ngResource', 'ngRoute', 'xeditable', 'ui.sortable'])

# CSRFのトークンを設定
app.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

# AngularJSがturbolinksと一緒に動くようにする
$(document).on 'ready page:load', ->
  angular.bootstrap(document.body, ['sampleApp'])

# ルートの設定
app.config ($routeProvider, $locationProvider) ->
  # html5モードを有効にする
  $locationProvider.html5Mode true

  $routeProvider.when '/',                    redirectTo: '/dashboard'
  $routeProvider.when '/dashboard',           templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl'
  $routeProvider.when '/todo_lists/:list_id', templateUrl: '/templates/todo_list.html', controller: 'TodoListCtrl'
