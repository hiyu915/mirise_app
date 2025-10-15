Rails.application.routes.draw do
  root "quote_pages#top"

  resources :users, only: [ :new, :create ]
  
  resource :account, only: [ :show, :destroy ] do
    get 'edit_password', to: 'accounts#edit_password'
    patch 'update_password', to: 'accounts#update_password'
  end

  get    "login",  to: "user_sessions#new"
  post   "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
end
