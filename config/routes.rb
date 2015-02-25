Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    delete '/logout' => 'users/omniauth_callbacks#log_out'
  end

  get '/login' => 'pages#login', as: :login

  resources :posts, only: [:new, :create, :index] do
    collection do
      get ':year/:month/:day' => :index, as: :date
      get 'tagged/:tag'       => :index, as: :tagged
    end
    member do
      post :upvote
      get :outbound
    end
    resources :comments, path: 'discussion', only: [:index, :create]
  end

  resource :user, as: :account, path: :account, only: [:edit, :update]

  resources :users, only: [] do
    member do
      match :finish_signup, via: [:get, :patch]
    end
    resources :posts, only: [] do
      collection do
        get '/submitted' => 'posts#submitted_by_user'
        get '/liked' => 'posts#liked_by_user'
      end
    end
  end

  get '/terms-of-service' => 'pages#terms_of_service'
  get '/privacy-policy'   => 'pages#privacy_policy'
  get '/about'            => 'pages#about'

  root to: 'posts#index'
end
