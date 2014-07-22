Rails.application.routes.draw do
  root 'welcome#index'
  post 'api/alchemy', to: 'alchemy#result', as: :api_new_alchemy_path
end
