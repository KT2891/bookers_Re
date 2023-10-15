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

end