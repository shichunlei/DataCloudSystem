Rails.application.routes.draw do

  resources :sanshiliujis
  resources :yuefus
  resources :year_fortunes
  resources :month_fortunes
  resources :week_fortunes
  resources :tomorrow_fortunes
  resources :today_fortunes
  resources :astros
  resources :huanglis
  resources :miyus
  resources :miyu_classifies
  resources :zhouyis
  resources :wenxindiaolongs
  resources :tiangongs
  resources :xuxiakes
  resources :soushenjis
  resources :shishuoxinyus
  resources :shanhaijings
  resources :guwens
  resources :mengxibitans
  resources :lvshichunqius
  resources :huangdineijings
  resources :sanguozhis
  resources :sunzibingfas
  resources :shijis
  resources :shijings
  resources :todayhistories
  resources :zhuangzis
  resources :daodejings
  resources :mengzis
  resources :lunyus
  resources :yuanqus
  resources :songcis
  resources :tangshis
  resources :recipe_processes
  resources :recipe_materials
  resources :recipes
  resources :recipe_classifies
  resources :car_actualtests
  resources :car_aircondrefrigerators
  resources :car_entcoms
  resources :car_seats
  resources :car_internalconfigs
  resources :car_lights
  resources :car_doormirrors
  resources :car_drivingauxiliaries
  resources :car_wheels
  resources :car_saves
  resources :car_chassisbrakes
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

  # 搜索品系
  get '/search_types' => "car_types#search_types"
  # 查询品系
  get '/find_types' => "car_types#find_types"

  # 搜索型号
  get '/search_models' => "car_models#search_models"
  # 查询型号
  get '/find_models' => "car_models#find_models"

  # 搜索菜谱分类
  get '/search_classify' => "recipe_classifies#search_classify"
  # 查询菜谱分类
  get '/find_classify' => "recipe_classifies#find_classify"

  # 搜索菜谱
  get '/search_recipe' => "recipes#search_recipe"
  # 查询菜谱
  get '/find_recipe' => "recipes#find_recipe"

  # 搜索企业
  get '/organization_all' => "organizations#organization_all"
  # 查询企业
  get '/find_organization' => "organizations#find_organization"

  # 搜索谜语类别
  get '/search_miyu_classify' => "miyu_classifies#search_classify"
  # 查询谜语类别
  get '/find_miyu_classify' => "miyu_classifies#find_classify"
end
