# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "landing#index"
  
  match '/about', to: 'landing#about', via: :get
  match '/register', to: 'users#new', via: :get
  get '/login', to: 'users#login_form'
  post '/login', to: 'sessions#create'
  
  resource :dashboard, only: %i[show create], controller: :users do
    resources :movies, only: [:show] do
      resources :viewing_parties, only: %i[new create]
    end
    get '/discover', to: 'discover#search'
  end

  resources :movies, only: [:show]
end
