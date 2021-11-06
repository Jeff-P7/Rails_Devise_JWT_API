# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'
    # origins '*'
    # origins 'example.com'

    resource '*',
             headers: :any,
             expose: %w[Authorization],
             #  expose: %w[Authorization access-token expiry token-type uid client],
             methods: %i[get post put patch delete options head]
  end

  ## Current set properties on https://github.com/waiting-for-dev/devise-jwt
  # resource '/api/*',
  #   headers: %w(Authorization),
  #   methods: :any,
  #   expose: %w(Authorization),
  #   max_age: 600
  # end
end
