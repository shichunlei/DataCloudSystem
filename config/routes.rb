Rails.application.routes.draw do

  resources :books
  resources :permissions
  resources :roles
  resources :users
  resources :organizations
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root :to => "home#index"

  # v1基础数据接口路由
  mount V1::API => '/api/v1/'
end
