Rails.application.routes.draw do

  devise_for :users
  scope '/admin' do
    resources :users
  end
  resources :organizations
  resources :events
  resources :surveys

  root 'welcome#index'
end
