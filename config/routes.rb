Rails.application.routes.draw do
  root to: "users#new"
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :questions do
    resources :answers, only: [:index, :new, :create]
  end

  resources :users
end
