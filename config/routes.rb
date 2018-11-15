Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  resources :teams, :except => [:delete] do
    get '/deactivate', to: 'teams#deactivate', as: 'deactivate'
    resources :users, :except => [:delete] do
      get '/deactivate', to: 'users#deactivate', as: 'deactivate'
    end
  end
end