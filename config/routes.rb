# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "landing#index"

  match '/about', to: 'landing#about', via: :get
  match '/register', to: 'users#new', via: :get
  get '/login', to: 'users#login_form'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resource :dashboard, only: %i[show create], controller: :users do
    resources :movies, only: [:show] do
      resources :viewing_parties, only: %i[new create]
    end
    get '/discover', to: 'discover#search'
  end

  namespace :admin do
    resource :dashboard, only: [:show], controller: :admin
    resources :users, only: [:show], controller: :users
  end
  resources :movies, only: [:show]
end
