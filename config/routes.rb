Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :searches, only: [:create]
  get 'analytics', to: 'searches#analytics'
  root 'searches#new'
end
