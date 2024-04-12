# frozen_string_literal: true

require 'omniauth'
require_relative '../openid_connect/shared_contexts/with_oidc_auth_jwts'

RSpec.configure do |config|
  config.include_context 'with oidc auth jwts', type: :request

  config.before(:each, type: :request) do
    host! 'localhost:3000'
    Warden.test_mode!
    # Set the default Devise resourece name to the Account model
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:account]

    # Set the default OmniAuth mock to the OIDC service
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:openid_connect]
  end

  # config.after(:each, type: :request) do
  #   Warden.test_reset!
  #   # Reset the OmniAuth mocks after each test
  #   OmniAuth.config.mock_auth[:openid_connect] = nil
  # end
end

# RSpec.configure do |config|
  # config.include OauthSpecHelper, type: :request
  # config.extend OmniAuth, type: :request
  # config.include OpenidConnectSpecHelper, type: :request
# end
