Rails.application.routes.draw do
  devise_for :users


  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end
  root "home#index"
  resources :companies, only: %i(new create show edit update index) do 
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
end
