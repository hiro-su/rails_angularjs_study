Rails.application.routes.draw do
  root 'templates#index'

  get '/dashboard' => 'templates#index'
  get '/todo_lists/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', constraints: { path: /.+/ }

  namespace :api, defaults: { format: :json } do
    resources :todo_lists, only: [:index, :show, :create, :update, :destroy] do
      resources :todos, only: [:index, :create, :update, :destroy]
    end
  end
end
