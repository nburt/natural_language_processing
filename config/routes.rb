Rails.application.routes.draw do
  root 'welcome#index'
  post 'api/alchemy', to: 'alchemy#create', as: :api_new_alchemy
  resources :query, only: [:index, :show]

  namespace :api do
    resources :terms, only: [:create]
  end
end
