Rails.application.routes.draw do

  root 'static_pages#home'

  get '/about' => 'static_pages#about'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  delete 'destroy_account' => 'users#destroy'

  resources :users
  resources :events
  resources :invitations, only: [:create, :destroy]

end
