Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/music_videos', to: 'projects#index_clips'
  get '/commercials', to: 'projects#index_commercials'

  resources :projects, only: [:new, :create, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
