Rails.application.routes.draw do

  get 'items/index'
  get 'items/show'
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

#顧客側


  scope module: :public do

    root to:"homes#top"
    get 'about' => 'homes#about'

    get 'items/genre_serch' => 'items#genre_search', as: "genre_search"
    resources :items, only: [:index,:show]

    get 'customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers' => 'customers#update'
    get 'customers/quit' => 'customers#quit'
    patch 'customers/out' => 'customers#out'

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index,:destroy,:update,:create]

    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new,:create,:index,:show]
    post 'orders/confirm' => 'orders#confirm'
    

    resources :shipping_addresses, only: [:index,:edit,:destroy,:update,:create]

  end

#管理者側

  namespace :admin do

    root to:"homes#top"

    resources :items, only: [:index,:new,:edit,:show,:update,:create]

    resources :genres, only: [:index,:edit,:update,:create]

    resources :customers, only: [:index,:edit,:update,:show]

    resources :orders, only: [:update,:show]

    resources :order_items, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
