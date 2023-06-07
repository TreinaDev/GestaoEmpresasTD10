Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :companies, only: %i(new create show edit update)
end
