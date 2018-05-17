Rails.application.routes.draw do
  devise_for :users,
    controllers: {:registrations => "users"}
  resources :users
  resources :organizations
  
  root 'users#index'
end
