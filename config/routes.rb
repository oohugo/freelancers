Rails.application.routes.draw do
  devise_for :employers
  root to: 'home#index'
end
