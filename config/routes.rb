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
  get '/users/:id/favorites', to: 'users#favorites', as: 'user_favorites'

  resources :requests
  post 'requests/check', to: 'requests#check', as: 'requests_check'
  get 'requests/confirm', to: 'requests#confirm', as: 'requests_confirm'
  get 'requests/complete', to: 'requests#complete', as: 'requests_complete'
  patch 'requests/finish', to: 'requests#finish', as: 'requests_finish'

  resources :evaluations, only: [:index, :edit, :update]
  get 'evaluations/unfinished', to: 'evaluations#unfinished', as: 'evaluations_unfinished'

  resources :rooms, only: [:index, :show]

  resources :talks, only: [:create]

  resources :favorites, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :scouts, only: [:new, :create]
  get 'scouts/complete', to: 'scouts#complete', as: 'scouts_complete'

  resources :entries, only: [:index, :create]
  get 'entries/complete', to: 'entries#complete', as: 'entries_complete'
  get 'entries/propriety', to: 'entries#propriety', as: 'entries_propriety'
  post 'entries/selection', to: 'entries#selection', as: 'entries_selection'

  resources :notifications, only: [:index]

end