Rails.application.routes.draw do
  root "quote_pages#top"

  resources :users, only: [ :new, :create ]
  resource :account, only: [ :show, :edit, :update, :destroy ]

  get    "login",  to: "user_sessions#new"
  post   "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
end
