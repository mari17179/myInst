Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post '/users/edit' => 'devise/registrations#edit'
  #  delete "/users/:id" => "users#destroy", as: :user
  end

  get '/newpost', to: 'posts#new'
  resources :posts, only: [:index, :show, :create, :destroy]
  resources :comments, only: [:index, :show, :create, :destroy]
  resources :posts do
    resources :comments, only: [:index, :show, :create, :destroy]
  end

  resource :follows, only: [:create, :destroy]
  resource :followings, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]

  get '/@:username', to: 'users#show', as: :profile
  get '/followings.:username', to: 'users#followings'
  get '/follows.:username', to: 'users#followers'
  get '/likes.:post_id', to: 'posts#likes'


end
