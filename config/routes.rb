Rails.application.routes.draw do
  get 'users/index'
  get 'users/edit'
  # if user is not an admin, going to /admins will give 404 error
  authenticated :user, -> (user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/users'
    get 'admin/transactions'
    patch 'admin/users/:id', to: 'admin#update', as: 'admin/user'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "items#index"
  resources :comments

  resources :posts do
    resources :comments
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
  get 'transactions', to: 'transactions#index'
end


