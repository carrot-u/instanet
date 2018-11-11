Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  resources :teams do
    resources :users
  end
end
