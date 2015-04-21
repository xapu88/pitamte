Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :categories, only: [:show]
  resources :questions
  resources :answers do
    member { post :vote }
  end

  root 'pages#home'
  get 'my_questions' => 'pages#my_questions'
  get 'my_answers' => 'pages#my_answers'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'
  get 'agreements' => 'pages#agreements'
end
