Rails.application.routes.draw do
  root 'pettings#index'

  resources :pettings, only: [:index, :show, :new, :create]
  resources :dogs, only: [:index, :show]
  resources :users, only: [:show]
  #signup
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  #sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
