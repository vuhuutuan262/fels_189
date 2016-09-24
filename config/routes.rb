Rails.application.routes.draw do
  root "static_page#home"
  get "/login", to: "session#new"
  get "/signup", to: "user#new"
  get "/home", to: "static_page#user"
end
