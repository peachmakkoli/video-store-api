Rails.application.routes.draw do
  resources :customers, only: [:index]
  resources :videos, only: [:index, :show, :create]
  post "rentals/check-out", to: "rentals#checkout", as: "checkout"
  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'
end
