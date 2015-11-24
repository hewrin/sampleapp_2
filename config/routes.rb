Rails.application.routes.draw do
  
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'session/new'

  get 'user/new'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'
  
  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup' => 'users#new'

  resources :users

  resources :account_activation, only: [:edit]

  resources :password_resets, only: [:edit, :new, :create, :update]

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

end

