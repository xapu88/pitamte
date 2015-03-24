Rails.application.routes.draw do
devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :questions
  resources :answers

  root 'pages#home'
  get 'my_questions' => 'pages#my_questions'
  get 'my_answers' => 'pages#my_answers'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
