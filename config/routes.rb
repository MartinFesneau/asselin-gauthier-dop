Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  get '/musicvideos', to: 'projects#index_clips'
  get '/commercials', to: 'projects#index_commercials'

  resources :projects, only: [:new, :index_clip, :index_commercials, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
