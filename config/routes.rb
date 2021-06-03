Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tweets, only: [:index, :new, :create]
  get 'validate_user', to: 'tweets#validate_user'

  root 'tweets#index'
end
