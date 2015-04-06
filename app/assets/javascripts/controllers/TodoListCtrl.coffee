angular.module('sampleApp').controller "TodoListCtrl", ($scope, $routeParams, TodoList, Todo) ->

  $scope.init = ->
    @todoListService = new TodoList(serverErrorHandler)
    @todoService = new Todo($routeParams.list_id, serverErrorHandler)
    $scope.list = @todoListService.find($routeParams.list_id, (res) -> $scope.totalTodos = res.totalTodos)

  $scope.addTodo = ->
    raisePositions($scope.list)
    todo = @todoService.create(description: $scope.todoText, completed: false)
    todo.position = 1
    $scope.list.todos.unshift(todo)
    $scope.todoText = ""

  $scope.deleteTodo = (todo) ->
    lowerPositionsBelow($scope.list, todo)
    @todoService.delete(todo)
    $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)

  $scope.toggleTodo = (todo) ->
    res = @todoService.update(todo, completed: todo.completed)
    todo.updated_at = res.updated_at

  $scope.search = ->
    params = {
      'q[description_cont]': $scope.descriptionCont,
      'q[completed_true]': $scope.completedTrue,
      'page': $scope.currentPage
    }

    $scope.list = @todoService.all(params, (res)-> $scope.totalTodos = res.totalTodos)

  $scope.updateListName = ->
    @todoListService.update($scope.list, name: $scope.list.name)

  $scope.updateDescription = (todo) ->
    @todoService.update(todo, description: todo.description)

  $scope.sortListeners = {
    orderChanged: (event) ->
      console.log "sorted: #{event.dest.index}"
  }

  $scope.positionChanged = (todo) ->
    @todoService.update(todo, target_position: todo.position)
    updatePositions($scope.list)

  $scope.sortListeners = {
    orderChanged: (event) ->
      newPosition = event.dest.index + 1
      todo = event.source.itemScope.modelValue
      todo.position = newPosition
      $scope.positionChanged(todo)
  }

  serverErrorHandler = ->
    alert("サーバーでエラーが発生しました。画面を更新し、もう一度試してください。")

  raisePositions = (list) ->
    angular.forEach list.todos, (todo) ->
      todo.position += 1

  lowerPositionsBelow = (list, todo) ->
    angular.forEach todosBelow(list, todo), (todo) ->
      todo.position -= 1

  todosBelow = (list, todo) ->
    list.todos.slice(list.todos.indexOf(todo), list.todos.length)

  updatePositions = (list) ->
    angular.forEach list.todos, (todo, index) ->
      todo.position = index + 1