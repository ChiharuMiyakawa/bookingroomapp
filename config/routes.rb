Rails.application.routes.draw do
  get 'users/profile'
  get 'users/account'
  get 'users/profile/edit', to: 'users#profile_edit'
  patch 'users/profile', to: 'users#profile_update', as: 'user_profile'
  get 'home/index'
  root 'home#index'

  
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :rooms do
    collection do 
      get :search
    end    
  end
  resources :reservations do
    collection do 
      post :confirm
    end
  end
end
