Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books
  resources :users 
  get 'home/about' => 'homes#about', as: 'about'
  root to: 'homes#top'
  
end
