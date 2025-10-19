Rails.application.routes.draw do
  root "quote_pages#top"
  get  "quote_pages/add_setting",      to: "quote_pages#add_setting"
  post "quote_pages/add_setting_item", to: "quote_pages#add_setting_item"
  delete "quote_pages/remove_setting_item/:id", to: "quote_pages#remove_setting_item", as: "remove_setting_item"

  get  "quote_pages/add_product",      to: "quote_pages#add_product"
  post "quote_pages/add_product_item", to: "quote_pages#add_product_item"
  delete "quote_pages/remove_product_item/:id", to: "quote_pages#remove_product_item", as: "remove_product_item"

  get "quote_pages/confirm",          to: "quote_pages#confirm"

  resources :users, only: [ :new, :create ]

  resources :master_data, only: [ :new, :create, :index ] do
    member do
      get :edit
      patch :update
      delete :destroy
    end
  end

  resource :account, only: [ :show, :destroy ] do
    get "edit_password", to: "accounts#edit_password"
    patch "update_password", to: "accounts#update_password"
  end

  get    "login",  to: "user_sessions#new"
  post   "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
end
