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
        collection do
          post :create_card
          get :new_manager
          post :create_manager
          get :new_fired
          post :fired
        end
        member do
          patch :deactivate_card
          patch :activate_card
          get :recharge_history
        end
      end
      resources :positions, only: %i(index new create show edit update)
    end
    collection do
      get :inactives
      get :search
    end

    member do
      put :activate
      put :deactivate
      get :manager
    end
  end

  namespace :api do
    namespace :v1 do
      resources :companies, only: %i[show index]
      resources :employee_profiles, only: %i(index)
    end
  end
end

