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
    resources :departments, only: %i(index new create show update edit) do
      resources :employee_profiles, only: %i(new create show edit update) do
        post :create_card, on: :collection
        patch :deactivate_card, on: :member
        patch :activate_card, on: :member
      end
      resources :positions, only: %i(new create show edit update)
    end
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :companies, only: %i[show index]
    end
  end
end

