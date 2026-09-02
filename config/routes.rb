Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/token", to: "gunbroker#token"
      get "items/search", to: "gunbroker#product"
      get "items/:id", to: "gunbroker#item"
      get "inventory", to: "gunbroker#inventory"
      delete "items/:id", to: "gunbroker#destroy_listing"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
