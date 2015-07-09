Rails.application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  devise_for :users, controllers: { registrations: 'registrations', 
    omniauth_callbacks: "users/omniauth_callbacks" }

  resources :posts do
    get :autocomplete_tag_name, :on => :collection
    post :search, :on => :collection
    resources :comments
  end

  resources :relationships, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]
  resources :tags, only: [:index]
  resources :users, except: [:index]

  namespace :admin do 
    resources :users
    resources :posts
  end

  root 'static_pages#home'

end
