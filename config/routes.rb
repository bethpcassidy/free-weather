Rails.application.routes.draw do
  root "forecasts#index"

  resources :forecasts
  resources :users
  post "/sessions" => "sessions#create"
end
