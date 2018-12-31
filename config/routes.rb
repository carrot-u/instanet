Rails.application.routes.draw do
  root 'welcome#index'

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'google5e8c349d90dac164.html', to: 'welcome#google5e8c349d90dac164', as: 'google5e8c349d90dac164'

  resources :searches, only: [:index, :show, :create]
  patch '/searches/:id', to: 'searches#create', as: 'create_new_search'

  resources :welcome, only: [:index]
  get '/nope', to: 'welcome#no_permission', as: 'no_permission'
  get '/users', to: 'welcome#users', as: 'users'
  get '/new_user', to: 'welcome#new_user', as: 'new_user'
  get '/first_team', to: 'welcome#first_team', as: 'first_team'
  get '/login_new_user', to: 'welcome#login_new_user', as: 'login_new_user'
  post '/users', to: 'welcome#create_new_user', as: 'create_new_user'
  patch '/users', to: 'welcome#update', as: 'user'

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
