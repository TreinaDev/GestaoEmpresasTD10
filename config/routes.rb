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

  resources :manager_emails, only: %i(create destroy)

  resources :companies, only: %i( new create show edit update index) do
    resources :recharge_histories, only: %i(new create)
    resources :departments, only: %i(index new create show update edit) do
      resources :employee_profiles, only: %i(new create show edit update) do
        post :create_card, on: :collection
        patch :deactivate_card, on: :member
        patch :activate_card, on: :member
        get :new_manager, on: :collection
        post :create_manager, on: :collection
        get :new_fired, on: :collection
        post :fired, on: :collection
      end
      resources :positions, only: %i(index new create show edit update)
    end
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
    get :manager, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :companies, only: %i[show index]
      resources :employee_profiles, only: %i(index)
    end
  end
end

