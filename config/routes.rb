Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end

  resources :departments, only: [:new, :create, :show, :update, :edit]
  root "home#index"
  resources :managers, only: %i(create destroy)
  resources :companies, only: %i( new create show edit update index) do
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
end
