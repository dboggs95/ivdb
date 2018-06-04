Rails.application.routes.draw do

  get 'search/results'
  resources :search

  resources :sessions

  resources :users

  resources :games do
    resources :reviews
  end

  get 'home/help'
  get 'home/about'
  get 'home/contact'
  resources :home

  root 'home#index'
  
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
