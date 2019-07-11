Rails.application.routes.draw do
  resources :comments
  resources :issues
  post '/payload', to: 'github#payload'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
