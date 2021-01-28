Rails.application.routes.draw do
  root 'posts#new'

  resources :posts
  get '/auth/:provider/callback', to: 'sessions#create'
end
