Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'

  shallow do
    resources :posters do
      resources :stands do
        resources :comments
      end
    end
  end
end
