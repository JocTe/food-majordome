Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/preferences", to: "pages#preferences"
  post "/preferences", to: "pages#submit_preferences"
  post "/save_session", to: "menus#save_to_session"


  resources :menus, only: [:new, :create]

  get "/menu", to: "menus#show"

  resources :recipes, only: [:show] do
    member do
      get "/instructions", to: "recipes#instructions"
    end
  end

  resources :recipes_preferences, only: [:create]

  get "/shoppinglist", to: "user_ingredients#index"
  get "/dashboard", to: "pages#dashboard"
end
