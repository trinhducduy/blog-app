Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :posts do
    get :autocomplete_tag_name, :on => :collection
    post :search, :on => :collection
    resources :comments
  end

  resources :relationships, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]
  resources :tags, only: [:index]
  resources :users, only: [:show, :edit, :update]

  get 'static_pages/home'

  get 'static_pages/help'

  root 'static_pages#home'

  mount Ckeditor::Engine => '/ckeditor'

end
