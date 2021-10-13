Rails.application.routes.draw do
  devise_for :workers, path: 'workers'
  devise_for :employers, path: 'employers'
  root to: 'home#index'
  resources :projects, only: %i[create new show] do
    get 'feedback', on: :member
    post 'suspend', on: :member
    post 'finished', on: :member
    resources :proposals, shallow: true do
      post 'accepted', on: :member
      post 'rejected', on: :member
    end
  end
  resources :perfil_workers, only: %i[create new show]
  resources :employers, only: :show
end
