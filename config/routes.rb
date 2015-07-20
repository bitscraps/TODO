Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create
    resources :lists do
       resources :tasks
    end
    resource :session, only: [:create, :destroy]
  end

  root 'front#index'
end
