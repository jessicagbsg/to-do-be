Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "up" => "rails/health#show", as: :rails_health_check
  
  scope '/api/v1' do
    resources :note do
      resources :todo
    end
  end

  root "note#index"
end
