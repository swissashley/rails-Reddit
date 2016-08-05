Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, only: [:new, :create, :index, :show, :destroy, :edit]
end