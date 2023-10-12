Rails.application.routes.draw do
<<<<<<< HEAD
  resources :user_books
  resources :users
  
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end


  resources :books do
=======
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
>>>>>>> editTest
    member do
      get :delete
    end
  end
<<<<<<< HEAD
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
=======
  resources :transactions do
    member do
      get :delete
    end
  end
  get 'member-items', to: 'items#member_items'
  get 'transactions', to: 'transactions#index'
>>>>>>> editTest
end
