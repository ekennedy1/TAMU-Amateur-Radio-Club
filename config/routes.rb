Rails.application.routes.draw do
  root to: "items#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }

  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  authenticated :user, -> (user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/users'
    get 'admin/transactions'
    patch 'admin/users/:id', to: 'admin#update', as: 'admin/user'
  end

  resources :items do
    member do
      get :delete
    end
  end

  resources :transactions do
    member do
      get :delete
    end
  end

  get 'member-items', to: 'items#member_items'
end
