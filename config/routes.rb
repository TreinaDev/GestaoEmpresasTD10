Rails.application.routes.draw do
  devise_for :users


  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
    end
  end

  resources :departments, only: [:new, :create, :show] 
  root "home#index"
  resources :companies, only: %i(new create show)
end
