Rails.application.routes.draw do
  root 'pettings#index'

  resources :pettings
  resources :dogs, only: [:index, :show]
  #owner namespace
   namespace :owner do
     resources :dogs, only: [:show, :new, :create, :edit, :update, :destroy]
   end
  resources :users, only: [:show]
  #signup
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  #sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#facebook'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
