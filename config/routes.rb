Rails.application.routes.draw do
  root 'pages#home'

  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
