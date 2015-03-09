Rails.application.routes.draw do
devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :questions, only: [:show, :create, :destroy]
  resources :answers, only: [:create, :destroy]

  root 'pages#home'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
