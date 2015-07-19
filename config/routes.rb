Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  namespace :api do
    resources :users, only: :create
    resources :lists
    resource :session, only: [:create, :destroy]
  end
end
