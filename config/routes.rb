Rails.application.routes.draw do
  namespace :public do
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about'
    resources :customers, only: [:index, :show, :edit, :update] do
     member do
      get 'unsubscribe'
      patch 'withdraw'
     end  
    end
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show] do
     collection do
      post 'confirm'
      get 'complete'
     end  
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :farmers, only: [:index, :show]
  end
  namespace :farmer do
    root to: 'homes#top'
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    resources :order_details, only: [:update]
    resources :posts
  end
  devise_for :farmers, controllers: {
   registrations: "farmer/registrations",
   sessions: "farmer/sessions"
  }
  devise_for :customers, controllers: {
    registrations: "customer/registrations",
    sessions: "customer/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
