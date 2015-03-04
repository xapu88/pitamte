Rails.application.routes.draw do
  root 'pages#home'

  get 'pages/contact'
  get 'pages/about'
  get 'pages/agreements'
end
