Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
                       omniauth_callbacks: "users/omniauth_callbacks",
                       registrations: "users/registrations",
                       passwords: "users/passwords",
                     }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root "posts#index"
  get "/users/:id", to: "users#show", as: "user"
  resources :users, only: %i(show destroy)
  resources :posts, expect: %i(show) do
    resources :photos, only: %i(create)
    resources :likes, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end
  resources :introductions, only: %i(index)
  resources :movies, only: %i(index)
  resources :members, only: %i(index)
  resources :contacts, only: %i(index create)
end
