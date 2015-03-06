Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :questions, only: [:create]

  root 'pages#home'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
