Rails.application.routes.draw do

  namespace :public do
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: 'about'
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
    resource :home, only: [:show, :edit]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    resources :order_details, only: [:update]
    resources :posts
    resources :diaries
    resources :post_images, only: [:new, :index, :show]
  end
  devise_for :farmer, controllers: {
   registrations: "farmer/registrations",
   sessions: "farmer/sessions"
  }
  devise_for :customer, path:'public', controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
