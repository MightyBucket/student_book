
Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :students
  resources :dashboard
  root 'dashboard#login'
  get "seating_plan" => 'seating_plan#index'
  post "seating_plan" =>'seating_plan#index'
  resources :groups, :controller => "classes"
  resources :user_files, only: [:index, :new, :create, :destroy]
  resources :users

end
