Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  scope '/api/v1' do
    resources :todo
  end

  root "todo#index"
end
