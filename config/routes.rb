Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  get 'home/about' => "homes#about", as: :about

  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update ] do
    resource :relationships, only: [:create, :destroy]
    get "/following" => "relationships#following", as: :following
    get "/followers" => "relationships#followers", as: :followers
  end

  resources :rooms, only: [:create, :show] do
    resource :messages, only: [:create, :destroy]
  end

  get 'search' => "searches#search", as: :search
  post 'datesearch' => "searches#datesearch", as: :datesearch

  resources :groups do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:new, :create, :edit, :update, :destroy]
  end

  get "book_sorts/goods" => "book_sorts#goods", as: :sort_goods
  get "book_sorts/comments" => "book_sorts#comments", as: :sort_comments
  get "book_sorts/visits" => "book_sorts#visits", as: :sort_visits
  get "book_sorts/star" => "book_sorts#star", as: :sort_stars

end