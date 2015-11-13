Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'

  resources :posters do
    resources :stands, shallow: true do
      resources :versions
    end
  end
  #devise_for :users
end
