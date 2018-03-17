Rails.application.routes.draw do
  resources :towns
  resources :students

  namespace :api do
    root 'api#index'
    resources :towns
  end

  root 'home#index'
end
