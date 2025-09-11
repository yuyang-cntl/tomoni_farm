Rails.application.routes.draw do

    root to: 'homes#top'

  scope module: :public, as: 'public' do
    get 'mypage', to: 'profiles#show', as: :customers_root
    get 'search', to: 'items#search', as: 'search'
    resources :customers, only: [:index, :show, :edit, :update] do
     member do
      get 'unsubscribe'
      patch 'withdraw'
     end
    end
    
    resources :order_details, only: [:index, :show]
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show] do
     collection do
      post 'confirm'
      get 'complete'
     end
    end

    resources :addresses
    resources :farmers, only: [:index, :show]
    resource :password_change, only: [:edit, :update]
    resources :comments, only: [:new, :index, :create, :show, :destroy]

    resources :diaries, only: [:index, :show] do
     resources :posts, only: [:show] do
      resources :comments, only: [:create]
      resource :like, only: [:create, :destroy]
     end
    end

    resource :profile, only: [:edit, :update, :show, :destroy] do
     get 'confirm_destroy', on: :collection
    end
  end

  namespace :farmer do
    root to: 'homes#top'
    resource :home, only: [:show, :edit]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    resources :order_details, only: [:update]
    resource :password_change, only: [:edit, :update]
    resources :likes, only: [:index]

    resources :diaries do
     resources :posts do
      resources :likes, only: [:index]
     end
    end
    resource :profile, only: [:edit, :update, :destroy] do
     get 'confirm_destroy', on: :collection
    end
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
