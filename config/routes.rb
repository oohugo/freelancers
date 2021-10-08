Rails.application.routes.draw do
  devise_for :employers
  root to: 'home#index'
  resources :projects, only: %i[create new]
end
