Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: {
  	sessions:      'admins/sessions',
  	passwords:     'admins/passwords',
  	registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
  	sessions:      'users/sessions',
  	passwords:     'users/passwords',
  	registrations: 'users/registrations'
  }

  # 管理者
  get '/admins', to: 'home#admins_top', as: 'admins_top'

  resources :request_genres, only: [:index, :create, :destroy]

  resources :skills, only: [:index, :create, :destroy]

  # ユーザー
  root to: 'home#top'
  get '/about', to: 'home#about', as: 'about'

  resources :users, only: [:index, :show, :edit, :update]
  get '/users/:id/relationships', to: 'users#relationships', as: 'user_relationships'
  get '/users/:id/evaluations', to: 'users#evaluations', as: 'user_evaluations'

  resources :requests, only: [:index, :new, :create, :show, :edit, :update]
  post 'requests/check', to: 'requests#check', as: 'requests_check'

  resources :evaluations, only: [:index, :edit, :update]
  get 'evaluations/unfinished', to: 'evaluations#unfinished', as: 'evaluations_unfinished'

  resources :rooms, only: [:index, :create, :show]

  resources :messages, only: [:create, :destroy]

  resources :favorites, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :scouts, only: [:new, :create, :destroy]
  get 'scouts/:id/propriety', to: 'scouts#propriety', as: 'scouts_propriety'
  post 'scouts/:id/selection', to: 'scouts#selection', as: 'scouts_selection'

  resources :entries, only: [:create, :destroy]
  get 'entries/:id/propriety', to: 'entries#propriety', as: 'entries_propriety'
  post 'entries/:id/selection', to: 'entries#selection', as: 'entries_selection'

  resources :notifications, only: [:index]

end