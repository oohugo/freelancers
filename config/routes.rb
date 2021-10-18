Rails.application.routes.draw do
  devise_for :workers, path: 'workers'
  devise_for :employers, path: 'employers'
  root to: 'home#index'
  resources :projects, only: %i[create new show] do
    resources :feedback_workers, only: :create
    resources :feedback_employers, only: :create
    resources :proposals, shallow: true do
      post 'cancel', on: :member
      post 'cancel_with_justification', on: :member
      post 'accepted', on: :member
      post 'rejected', on: :member
    end
    get 'search', on: :collection
    get 'feedback', on: :member
    post 'suspend', on: :member
    post 'finished', on: :member
    post 'avaliable', on: :member
  end
  resources :perfil_workers, only: %i[create new show]
  resources :employers, only: :show
end
