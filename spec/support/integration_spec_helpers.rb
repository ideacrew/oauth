# frozen_string_literal: true

RSpec.configure do |config|
  # Load Warden's test helpers to enable sign_in and sign_out in request specs
  config.include DeviseRequestSpecHelpers, type: :request

  # Route URL helpers enable references such as 'root_url' in Request specs to indicate the URL to make a request
  config.include Rails.application.routes.url_helpers, type: :request

  # config.include OauthIntegrationMacros, type: :request
  # config.extend Omniauth, type: :request
end

# RSpec.shared_context :login_account do
#   let(:service) { :keycloak_openid }
#   let(:account) { Accounts::CreateOrUpdateFromOauth.new.call(OmniAuth.config.mock_auth[service]).success }
#   before { sign_in account }
# end
