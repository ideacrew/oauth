# frozen_string_literal: true

require 'omniauth/openid_connect'

# Configure Devise OmniAuth for test mode using OpenID Connect (OIDC)
module OidcSpecHelper
  include Warden::Test::Helpers

  # OmniAuth.configure do |config|
  #   # Set OpenID Connect (OIDC) paylad as the default OmniAuth sign-in credentials
  #   config.mock_auth[:openid_connect] = OmniAuth::AuthHash.new(oidc_id_token_payload)
  # end

  # def self.included(base)
  # end

  def login_with_oidc(resource = :openid_connect)
    login_as(resource, scope: :openid_connect)
    resource
    # binding.pry
    # account = Accounts::CreateOrUpdateFromOauth.new.call(OmniAuth.config.mock_auth[resource].success?)
    # sign_in account
  end

  def logout_oidc(resource = :openid_connect)
    logout(warden_scope(resource))
  end

  def json
    JSON.parse(response.body).with_indifferent_access
  end

  private

  def warden_scope(resource)
    resource.to_s.class

    
    resource.class.name.underscore.to_sym
  end

  def sign_request_with_oauth(token = nil, options = {})
    ActionController::TestRequest.use_oauth = true
    @request.configure_oauth(current_account, token, options)
  end

  def two_legged_sign_request_with_oauth(account = nil, options = {})
    ActionController::TestRequest.use_oauth = true
    @request.configure_oauth(account, nil, options)
  end

  def add_oauth2_token_header(token, _options = {})
    request.env['HTTP_AUTHORIZATION'] = "OAuth #{token.token}"
  end

  def refresh_access_token!
    result = access_token.refresh!
    store_token(result)
    save
  rescue OAuth2::Error
    false
  end
end
