Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end
  resources :departments, only: [:new, :create, :show]
  resources :managers, only: %i(create destroy)
  resources :companies, only: %i( new create show edit update index) do
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
  resources :employee_profiles, only: %i(new create show)
end
