Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'homes/about' => "homes#about", as: :about

  resources :books
  resources :users, only: [:index, :show, :edit, :update ]

end