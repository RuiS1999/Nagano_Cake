Rails.application.routes.draw do
  scope module: :public do
    root to: 'homes#top'
    get     '/about' => 'homes#about', as: 'about'

    get     'customers/retire'
    patch   'customers/withdrawal'

    delete  'cart_items/destroy_all'

    post    'orders/confirm'
    get     'orders/complete'

    resources :addresses,   only: [:new, :edit, :create, :update, :destroy]
    resources :items,       only: [:index, :show]
    resources :cart_items,  only: [:index, :update, :destroy, :create]
    resources :orders,      only: [:new, :index, :show, :create]
    resource  :customers,   only: [:show, :edit, :update]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :items,       only: [:new, :index, :show, :edit, :create, :update]
    resources :genres,      only: [:index, :edit, :create, :update]
    resources :customers,   only: [:index, :show, :edit, :update]
    resources :orders,      only: [:show, :update]
    resources :order_goods, only: [:update]
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
