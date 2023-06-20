Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    get :profile, on: :collection
    member do
      patch :block
      patch :unblock
    end
  end

  root "home#index"

  resources :managers, only: %i(create destroy)

  resources :companies, only: %i( new create show edit update index) do
    resources :departments, only: %i(:new, :create, :show, :update, :edit) do
      resources :positions, only: %i(new create show edit update)
    end
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
end
