Rails.application.routes.draw do
  devise_for :accounts, controllers: { omniauth_callbacks: 'accounts/omniauth_callbacks' }

  resources :oauths, only: [:index]

  # devise_scope :account do
  #   get 'sign_in', :to => 'devise/sessions#new', :as => :new_account_session
  #   post 'sign_in', :to => 'devise/session#create', :as => :account_session
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_account_session
  # end

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
