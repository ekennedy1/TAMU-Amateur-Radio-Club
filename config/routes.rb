Rails.application.routes.draw do
  get 'users/index'

  resources :maintenance_items
  # if user is not an admin, going to /admins will give 404 error
  authenticated :user, -> (user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/transactions', to: 'admin#transactions', as: 'admin_transactions'
    patch 'admin/users/:id', to: 'admin#update', as: 'admin_user_update'
    get 'admin/users', to: 'admin#users', as: 'admin_users'
    get 'items/index', as: :admin_items
    get 'admin/users', to: 'admin#users', as: :users
    post 'admin/users', to: 'admin#create', as: :create_user
    patch 'admin/users/:id', to: 'admin#update', as: :user
  end

  namespace :admin do
    get '/', to: 'admin#index', as: 'admin_root'
    resources :users, except: [:destroy] do
      patch :update, on: :member
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # root to: "items#index"
  root to: 'items#member_items'


  put 'items/:id/checkout', to: 'items#checkout', as: 'checkout_item'

  get '/items/export', to:'items#export'
  post 'items/import', to: 'items#import', as: 'import_items'

  resources :items, except: [:index] do
    member do
      get :delete
      put 'checkout'
      get 'checkout'
      #post :button_action
    end
  end

  put 'transactions/:id/approve', to: 'transactions#approve', as: 'approve_transaction'

  resources :transactions do
    member do
      get :delete
      put 'approve'
      get 'approve'
    end
  end

  get 'member-items', to: 'items#member_items'
  get 'transactions', to: 'transactions#index'
end
