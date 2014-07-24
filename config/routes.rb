Rails.application.routes.draw do
  root 'welcome#index'
  post 'api/alchemy', to: 'alchemy#query', as: :api_new_alchemy
end
