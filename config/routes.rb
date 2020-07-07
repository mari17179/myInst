Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get '/newpost', to: 'posts#new'
  resources :posts, only: [:index, :show, :create, :destroy]
  resources :comments, only: [:index, :show, :create, :destroy]
  resources :posts do
    resources :comments, only: [:index, :show, :create, :destroy]
  end

  get '/@:username', to: 'users#show', as: :profile


end
