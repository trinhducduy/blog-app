Rails.application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  devise_for :users, controllers: { registrations: 'registrations', 
    omniauth_callbacks: "users/omniauth_callbacks" }
  match '/users/:id/finish_signup', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup
  
  resources :posts do
    get :autocomplete_tag_name, on: :collection
    post :search, on: :collection
    resources :comments, except: [:destroy]
  end

  post '/comments/:id/reply', to: 'comments#reply', as: :comment_reply

  resources :comments, only: [:destroy]

  resources :relationships, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]
  resources :tags, only: [:index]
  resources :users, except: [:index]
  
  resources :links do
    resources :comments, except: [:destroy]
  end

  namespace :admin do 
    resources :users
    resources :posts
    resources :topics
  end

  root 'static_pages#home'

end
