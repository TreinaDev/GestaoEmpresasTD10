Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :companies, only: %i( show edit update ) do 
    get 'inactives', on: :collection
    put :activate, on: :member
    put :deactivate, on: :member
  end
end
