Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'

  shallow do
    resources :posters do
      member do
        put :up
        put :down
      end
      resources :stands do
        resources :comments
      end
    end
  end
  resources :supports
end
