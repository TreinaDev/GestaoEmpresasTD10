Rails.application.routes.draw do
  devise_for :users


  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end
  root "home#index"
  resources :companies, only: %i(new create show) do
    resources :departments do
      resources :positions, only: %i(new create show edit update)
    end
  end
end
