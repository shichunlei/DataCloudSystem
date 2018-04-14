Rails.application.routes.draw do

  resources :car_gearboxes
  resources :car_engines
  resources :car_bodies
  resources :car_basics
  resources :car_models
  resources :car_types
  resources :car_brands
  resources :permissions
  resources :roles
  resources :users
  resources :organizations
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root :to => "home#index"

  # v1基础数据接口路由
  mount V1::API => '/api/v1/'

  # 搜索品牌
  get '/search_brands' => "car_brands#search_brands"
  # 查询品牌
  get '/find_brands' => "car_brands#find_brands"

  # 搜索品牌
  get '/search_types' => "car_types#search_types"
  # 查询品牌
  get '/find_types' => "car_types#find_types"
end
