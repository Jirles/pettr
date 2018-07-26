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

  # API namespace
  namespace :api do 
    get '/pettings' => 'data#pettings'
    get '/pettings/:id' => 'data#petting'
    get '/users/:id' => 'data#user'
    get '/dogs' => 'data#dogs'
    get '/dogs/:id' => 'data#dog'
    post '/pettings/:id/comments' => 'data#create_comment'
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
