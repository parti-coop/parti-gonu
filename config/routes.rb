Rails.application.routes.draw do
  devise_for :users
  root 'posters#index'

  shallow do
    resources :posters do
      member do
        put :up
        put :down
        put :in_favor
        put :oppose
      end
      resources :stands do
        resources :comments
        member do
          put :in_favor
          put :down
        end
      end
    end
  end
  resources :supports
end
