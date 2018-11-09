Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]
  resources :bloggers, only: [:index, :show, :new, :create]
  resources :destinations, only: [:index, :show]
end
