Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete '/logout' => 'users/omniauth_callbacks#log_out'
  end

  resources :posts do
    member do
      post :upvote
      get :outbound
    end
    resources :comments, path: 'discussion', only: [ :index, :create ]
  end

  resources :users do
    member do
      match :finish_signup, via: [ :get, :patch ]
    end
    resources :posts
  end

  get '/terms-of-service' => 'pages#terms_of_service'
  get '/privacy-policy'   => 'pages#privacy_policy'
  get '/about'            => 'pages#about'

  root to: 'posts#index'
end
