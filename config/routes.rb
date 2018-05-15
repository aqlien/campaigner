Rails.application.routes.draw do

  devise_for :users,
    controllers: {:registrations => "users"}
  resources :users
  root 'users#index'
end
