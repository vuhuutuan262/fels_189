Rails.application.routes.draw do
  root "static_page#home"
  get "/home", to: "static_page#user"
  namespace :admin do
    root "dash_board#index", as: :home
    resources :categories, except: :index
    resources :words, only: [:index, :new, :create]
    resources :users, only: [:index, :show, :destroy]
  end
  resources :users
  get "/about", to: "static_page#about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :relationships, only: [:index, :create, :destroy]
  resources :users, except: :index
  resources :lessons, except: [:destroy]
end
