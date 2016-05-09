Rails.application.routes.draw do
  
  root                               'pages#index'
  get    'about'                  => 'pages#about'

    get    '/home1'               => 'pages#home1'
    get    'home/home2'           => 'pages#home2'
    get    'home/home3'           => 'pages#home3'

  get    'users/index'
  get    'users/new'
  get    'users/edit'
  
  get    'reports/report1'        => 'pages#report1'
  get    'reports/report2'        => 'pages#report2'
  get    'reports/report3'        => 'pages#report3'
  
  get    'schedule/schedule1'     => 'pages#schedule1'
  get    'schedule/schedule2'     => 'pages#schedule2'
  get    'schedule/schedule3'     => 'pages#schedule3'
  
  #new report pages
  get 'reports/donor'             => 'reports#donor'
  get 'reports/truck'             => 'reports#truck'
  
  get    'template'               => 'pages#template'
  

  resources :users

  resources :pickups

end
