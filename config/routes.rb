Rails.application.routes.draw do
  root "static_page#home"
  get "/home", to: "static_page#user"
  namespace :admin do
    root "dash_board#index"
  end
  get "/about", to: "static_page#about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: [:show]
end
