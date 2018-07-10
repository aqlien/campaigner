Rails.application.routes.draw do

  devise_for :users
  scope '/admin' do
    resources :users
    resources :filters
  end
  resources :organizations
  resources :events

  scope '/surveys' do
    get '/', to: 'surveys#new', as: 'available_surveys'
    post '/:survey_code', to: 'surveys#create', as: 'take_survey'
    get '/:survey_code', to: 'surveys#export', as: 'export_survey'
    get '/:survey_code/:response_set_code', to: 'surveys#show', as: 'view_my_survey'
    get '/:survey_code/:response_set_code/take', to: 'surveys#edit', as: 'edit_my_survey'
    put '/:survey_code/:response_set_code', to: 'surveys#update', as: 'update_my_survey'
  end

  root 'welcome#index'
end
