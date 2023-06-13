Rails.application.routes.draw do
  devise_for :users


  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end
  root "home#index"
end
