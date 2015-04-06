json.id @todo_list.id
json.name @todo_list.name
json.updated_at @todo_list.updated_at
json.todos @todo_list.todos.page(1) do |todo|
  json.id          todo.id
  json.description todo.description
  json.completed   todo.completed
  json.position    todo.position
  json.updated_at  todo.updated_at
end
json.totalTodos @todo_list.todos.count