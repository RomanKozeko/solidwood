Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'index#index', controller: IndexController

  get '/about' => 'pages#about'

  # get '/catalog' => 'catalog#index'
  get '/catalog/:filter' => 'catalog#index'

  resources :news, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :catalog, only: :index
  resource :cart, only: :show
  resources :order_items, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
