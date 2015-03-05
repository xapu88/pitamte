Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'

  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
