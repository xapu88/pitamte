Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :categories, only: [:show], path: 'kategorije'
  resources :questions, path: 'pitanja'
  resources :answers, path: 'odgovori' do
    member { post :vote }
  end

  root 'pages#home'
  get 'moja_pitanja' => 'pages#my_questions', as: 'my_questions'
  get 'moji_odgovori' => 'pages#my_answers', as: 'my_answers'
  get 'o_nama' => 'pages#about', as: 'about'
  get 'uslovi_koriscenja' => 'pages#agreements', as: 'agreements'

  resources :messages, only: [:new, :create], path: 'kontakt'
end
