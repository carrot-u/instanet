Rails.application.routes.draw do
  get 'welcome/index'
  resources :teams do
    resources :users
  end
end
