Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end

  root "home#index"
  
  resources :managers, only: %i(create destroy)

  resources :companies, only: %i( new create show edit update index) do
    resources :departments, only: [:new, :create, :show, :update, :edit], on: :member
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
    resources :departments do
      resources :positions, only: %i(new create show edit update)
    end
  end
end
