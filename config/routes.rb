Rails.application.routes.draw do
  get 'users/index'

  resources :maintenance_items
  # if user is not an admin, going to /admins will give 404 error
  authenticated :user, -> (user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/users'
    get 'admin/transactions'
    patch 'admin/users/:id', to: 'admin#update', as: 'admin/user'
    get 'items/index', as: :admin_items
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
