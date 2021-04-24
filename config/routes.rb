Rails.application.routes.draw do
  devise_for :users
  root to:'events#index'
  resources :events do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :tasks
  resources :users, only: :show
end
