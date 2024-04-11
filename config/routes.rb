Rails.application.routes.draw do
  devise_for :accounts, controllers: { omniauth_callbacks: 'accounts/omniauth_callbacks' }

  resources :oauths, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
