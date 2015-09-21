Rails.application.routes.draw do

  #Initialize devise routes
  devise_for :players

  #Pusher authentication mode //subscribe to private channels

    post "pusher/auth"


  #Play and Nested resources
  root to: 'plays#index'
  resources :plays do
    resources :messages, only: [:index, :show, :create]
    resources :moves, only: [:show, :create]
  end

  #Player profile
  get '/:id', to: 'players#show', as: :player

end
