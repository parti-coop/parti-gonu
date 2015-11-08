Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'
  #devise_for :users
end
