Rails.application.routes.draw do
  resources :towns
  resources :students

  root 'home#index'
end
