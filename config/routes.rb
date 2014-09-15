Rails.application.routes.draw do

  devise_scope :user do
    get '/login', to: 'devise/omniauth_callbacks#passthru', provider: 'twitter', as: :login
  end

  devise_for :users

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :posts
  resources :users do
    resources :posts
  end

  root to: 'posts#index'
end
