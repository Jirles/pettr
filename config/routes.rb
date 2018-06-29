Rails.application.routes.draw do
  root 'application#home'
  
  resources :pettings, only: [:index]
  resources :dogs, only: [:index, :show]
  resources :users, only: [:show]

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
