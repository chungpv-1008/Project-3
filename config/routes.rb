Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    devise_for :users, controllers: {sessions: "users/sessions",
      registrations: "users/registrations", passwords: "users/passwords"}
    devise_scope :user do
      get "/signup", to: "users/registrations#new"
      post "/signup", to: "users/registrations#create"
      get "/login", to: "users/sessions#new"
      post "/login", to: "users/sessions#create"
      get "/logout", to: "users/sessions#destroy"
      get "/profile", to: "users#show"
      get "/profile/edit", to: "users#edit"
      get "/profile/change_password", to: "users/passwords#edit"
      get "/about", to: "users#about"
      get "/forgot_password", to: "users/passwords#new"
    end

    resources :users do
      resources :courses, only: :index
      resources :transactions, only: :index
    end

    resources :courses do
      resources :videos
    end

    resources :categories do
      member do
        get :courses, action: :show
      end
    end

    resources :searches, only: :index
    resources :transactions

    namespace :admin do
      resources :categories
      resources :courses
    end
    get "/admin", to: "admin/admins#index"
  end
end
