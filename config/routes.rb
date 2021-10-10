Rails.application.routes.draw do
  devise_for :workers, path: 'workers'
  devise_for :employers, path: 'employers'
  root to: 'home#index'
  resources :projects, only: %i[create new show] do
    resources :proposals, shallow: true
  end
  resources :perfil_workers, only: %i[create new]
  resources :employers, only: :show
end
