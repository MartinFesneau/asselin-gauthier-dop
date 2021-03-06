Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  get "/contact", to: 'pages#contact'
  get "/cv", to: 'pages#cv'

  patch 'move_project', to: 'projects#move_project'
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
