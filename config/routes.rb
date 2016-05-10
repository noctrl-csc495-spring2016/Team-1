Rails.application.routes.draw do

  root                               'auth#new'

  get    'about'                  => 'pages#about'

  get    'home/home1'             => 'pages#home1'
  get    'home/home2'             => 'pages#home2'
  get    'home/home3'             => 'pages#home3'

  get    'users/index'
  get    'users/new'
  get    'users/edit'
  
  get    'reports/report1'        => 'pages#report1'
  get    'reports/report2'        => 'pages#report2'
  get    'reports/report3'        => 'pages#report3'
  
  get    'schedule/schedule1'     => 'days#schedule1'
  get    'schedule/schedule2'     => 'days#schedule2'
  get    'schedule/schedule3'     => 'days#schedule3'
  
  #new report pages
  get 'reports/donor'             => 'reports#donor'
  get 'reports/truck'             => 'reports#truck'
  
  get    'template'               => 'pages#template'
  
  get    'login'                  => 'auth#new'
  post   'login'                  => 'auth#create'
  delete 'logout'                 => 'auth#destroy'
  
  resources :users
  resources :days
  resources :pickups
end