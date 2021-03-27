require "sidekiq/web"

Rails.application.routes.draw do
  if Rails.env.development?
    mount Sidekiq::Web => "/sidekiq"
  end

  root "posts#new"

  resources :posts
  # get "/auth/:provider/callback", to: "sessions#create"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  devise_scope :user do
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end
end
