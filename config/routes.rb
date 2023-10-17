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

end