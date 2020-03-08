Rails.application.routes.draw do
  root 'top#index'

  get 'lineup_manage/:team/:year' => 'lineup_manage#index', as: :index_lineup_manage
  post 'lineup_manage' => 'lineup_manage#create', as: :create_lineup_manage
  post 'lineup_manage_like' => 'lineup_manage_like#update'
  post 'lineup_manage_user_comment' => 'lineup_manage_user_comment#create'

  get 'rotation_manage/:team/:year' => 'rotation_manage#index', as: :index_rotation_manage
  post 'rotation_manage' => 'rotation_manage#create', as: :create_rotation_manage
  post 'rotation_manage/:team/:year/comment' => 'rotation_commnet#create_comment', as: :create_rotation_comment
  post 'rotation_manage_user_comment' => 'rotation_manage_user_comment#create'

  post 'battle/index' => 'battle#index', as: :index_battle
  post 'battle/create' => 'battle#create', as: :create_battle

  post 'dream_battle/index' => 'dream_battle#index', as: :index_dream_battle
  post 'dream_battle/create' => 'dream_battle#create', as: :create_dream_battle

  get 'ranking/:league/:year' => 'ranking#index', as: :index_ranking
  post 'ranking_manage' => 'ranking#create', as: :create_ranking
  post 'ranking/:league/:year/comment' => 'ranking#create_comment', as: :create_ranking_comment  

  resources :users, only: [:new, :create, :edit, :update]

  namespace :user do
    resources :mypage, only: [:index]
    resources :opening_starting_lineup, only: [:create, :edit]
  end

  get 'dream_lineup' => 'dream_lineup#index', as: :index_dream_lineup
  post 'dream_lineup' => 'dream_lineup#create', as: :create_dream_lineup

  get 'login' => 'sessions#new', as: :login
  post 'session' => 'sessions#create', as: :session
  delete 'session' => 'sessions#destroy'
end
