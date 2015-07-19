Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create
    resources :lists
    resource :session, only: [:create, :destroy]
  end
end
