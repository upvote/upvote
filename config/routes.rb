Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts
  resources :users do
    member do
      match :finish_signup, via: [ :get, :patch ]
    end
    resources :posts
  end

  root to: 'posts#index'
end
