Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'

  resources :posters
  #devise_for :users
end
