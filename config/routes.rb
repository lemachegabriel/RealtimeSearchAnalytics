Rails.application.routes.draw do
  resources :searches, only: [:create]
  get 'analytics', to: 'searches#analytics'
  root 'searches#new'
end
