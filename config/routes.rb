Rails.application.routes.draw do
  resources :books do
    member do
      post :borrow
      patch :return
    end
  end

  # get "/borrowers/:name", to: "loans#borrower_history", as: "borrower_history"
  get "/borrower_history", to: "loans#borrower_history", as: "borrower_history"
  resources :loans, only: [ :index ]

  root "books#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
