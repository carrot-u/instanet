Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  get '/users', to: 'welcome#users', as: 'users'
  get '/new_user', to: 'welcome#new_user', as: 'new_user'
  post '/users', to: 'welcome#create_new_user', as: 'create_new_user'
  resources :teams, :except => [:destroy] do
    get '/deactivate', to: 'teams#deactivate', as: 'deactivate'
    resources :users, :except => [:destroy] do
      get '/deactivate', to: 'users#deactivate', as: 'deactivate'
      resources :user_badges, :except => [:destroy, :show, :edit, :update] do
        get '/deactivate', to: 'user_badges#deactivate', as: 'deactivate'
      end
      resources :user_skills, :except => [:destroy, :show] do
        get '/deactivate', to: 'user_skills#deactivate', as: 'deactivate'
      end
    end
  end
end
