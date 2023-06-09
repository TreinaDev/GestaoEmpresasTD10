Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :companies, only: %i(index show)
  resources :managers, only: %i(create destroy)

end
