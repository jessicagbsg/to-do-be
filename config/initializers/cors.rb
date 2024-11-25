Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173"

    resource "/graphql",
      headers: :any,
      methods: [ :get, :post, :options ],
      credentials: true
  end
end
