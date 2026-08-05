Rails.application.routes.draw do
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/profile", to: "users#profile"

  namespace :admin do
    resources :users
  end

  scope path: "/api/v1" do
    resources :users
  end
end