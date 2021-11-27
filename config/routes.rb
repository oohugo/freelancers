Rails.application.routes.draw do
  devise_for :workers, path: 'workers'
  devise_for :employers, path: 'employers'
  root to: 'home#index'
  concern :feedbackable do
    resources :feedbacks, only: :create
  end

  resources :projects, only: %i[create new show] do
    resources :employers, concerns: :feedbackable
    resources :workers, concerns: :feedbackable
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
  resources :perfil_workers, only: %i[create new show edit update]
  resources :employers, only: :show 
  end
