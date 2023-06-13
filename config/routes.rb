Rails.application.routes.draw do
  devise_for :users


  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end
  root "home#index"
  resources :companies, only: %i(index show)
  resources :managers, only: %i(create destroy)

end
