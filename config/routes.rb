Rails.application.routes.draw do
  namespace :public do
    get 'homes/top'
    get 'homes/about'
    resources :customers, only: [:index, :show, :edit, :update] do
     member do
      get 'unsubscribe'
      patch 'withdraw'
     end  
    end
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show, :confirm, :complete] do
     collection do
      post 'confirm'
      get 'complete'
     end  
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :farmers, only: [:index, :show]
  end
  namespace :farmer do
    get 'homes/top'
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    resources :order_details, only: [:update]
    resources :posts
  end
  devise_for :farmers, controllers: {
   registration: "farmers/registrations",
   session: "farmers/sessions"
  }
  devise_for :customers, controllers: {
    registration: "customers/registrations",
    session: "customers/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
