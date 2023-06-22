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
    resources :departments, only: [:new, :create, :show, :update, :edit] do
      resources :positions, only: %i(new create show edit update)
      resources :employee_profiles, only: %i(new create show) do
        get :new_manager, on: :collection
        post :create_manager, on: :collection
      end
    end
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
end
