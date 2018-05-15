Rails.application.routes.draw do
  devise_for :users
  resources :transactions, only: [:index, :create]
    
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
