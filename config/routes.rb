Rails.application.routes.draw do
  resources :posts
  get '/auth/:provider/callback', to: 'sessions#create'
end
