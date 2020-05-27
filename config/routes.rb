Rails.application.routes.draw do
  resources :customers, only: [:index]
  resources :videos, only: [:index, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
