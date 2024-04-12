# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationController' do
  include OidcSpecHelper

  describe 'Devise OAuth resource configuration' do
    subject(:resource) { Devise.mappings[:account] }

    it 'is configured for the account model' do
      expect(resource.class_name).to eq('Account')
    end

    it 'is configured for the Devise failure app' do
      expect(resource.failure_app).to eq(Devise::FailureApp)
    end

    it 'is configured for Devise omniauthable module' do
      expect(resource.modules).to eq([:omniauthable])
    end

    it 'is configured for Devise omniauthable callbacks' do
      expect(resource.routes).to eq([:omniauth_callback])
    end

    it 'is configured for the Devise session controllers' do
      expect(resource.controllers).to eq({:omniauth_callbacks=>"accounts/omniauth_callbacks"})
    end

    it 'is configured for Signout via delete HTTP method' do
      expect(resource.sign_out_via).to eq(:delete)
    end

    # it 'is configured for the Devise omniauth callbacks controller' do
    #   expect(resource.controllers).to eq({ omniauth_callbacks: 'accounts/auth/openid_connect' })
    # end
  end

  describe 'Devise OAuth OIDC configuration' do
    subject(:oidc_strategy) { Devise.omniauth_configs[:openid_connect] }

    let(:oidc_client_options) do
      {
        identifier: 'sbm-service',
        secret: 'GKw1oskHcObgZnLlDtIBiXdBbAiHMeeD',
        scheme: 'http',
        host: '0.0.0.0',
        port: 8180,
        redirect_uri: 'http://127.0.0.1:3000/accounts/auth/openid_connect_callbacks',
        authorization_endpoint: 'realms/ideacrew/protocol/openid-connect/auth',
        token_endpoint: 'realms/ideacrew/protocol/openid-connect/token',
        userinfo_endpoint: 'realms/ideacrew/protocol/openid-connect/userinfo',
        jwks_uri: 'realms/ideacrew/protocol/openid-connect/certs',
        end_session_endpoint: 'realms/ideacrew/protocol/openid-connect/logout'
      }
    end

    let(:oidc_strategy_config) do
      {
        'setup' => false,
        'skip_info' => false,
        'origin_param' => 'origin',
        'name' => :openid_connect,
        'client_options' => {
          'identifier' => 'sbm-service',
          'secret' => 'GKw1oskHcObgZnLlDtIBiXdBbAiHMeeD',
          'redirect_uri' => 'http://127.0.0.1:3000/accounts/auth/openid_connect_callbacks',
          'scheme' => 'http',
          'host' => '0.0.0.0',
          'port' => 8180,
          'authorization_endpoint' => 'protocol/openid-connect/auth',
          'token_endpoint' => 'protocol/openid-connect/token',
          'userinfo_endpoint' => 'protocol/openid-connect/userinfo',
          'jwks_uri' => 'protocol/openid-connect/certs',
          'end_session_endpoint' => 'protocol/openid-connect/logout'
        },
        'issuer' => nil,
        'discovery' => :false,
        'client_signing_alg' => nil,
        'jwt_secret_base64' => nil,
        'client_jwk_signing_key' => nil,
        'client_x509_signing_key' => nil,
        'scope' => [:openid],
        'response_type' => :code,
        'require_state' => true,
        'response_mode' => nil,
        'display' => nil,
        'prompt' => nil,
        'hd' => nil,
        'max_age' => nil,
        'ui_locales' => nil,
        'id_token_hint' => nil,
        'acr_values' => nil,
        'send_nonce' => true,
        'send_scope_to_token_endpoint' => false,
        'client_auth_method' => nil,
        'post_logout_redirect_uri' => nil,
        'extra_authorize_params' => {
        },
        'allow_authorize_params' => [],
        'uid_field' => 'sub',
        'pkce' => false,
        'pkce_verifier' => nil,
        'logout_path' => '/logout'
      }
    end

    let(:keycloak_oidc_grant_types_supported) { { grant_types_supported: grant_types_supported } }
    let(:grant_types_supported) do
      %w[
        authorization_code
        implicit
        refresh_token
        password
        client_credentials
        urn:openid:params:grant-type:ciba
        urn:ietf:params:oauth:grant-type:token-exchange
        urn:ietf:params:oauth:grant-type:device_code
      ]
    end

    let(:keycloak_oidc_scopes_supported) { { scopes_supported: scopes_supported } }
    let(:scopes_supported) do
      %w[openid profile address email phone web-origins offline_access microprofile-jwt roles acr]
    end

    it 'is configured for an OICD provider' do
      expect(Devise.omniauth_providers).to include(:openid_connect)
    end

    it 'is configured with an OICD strategy' do
      expect(oidc_strategy.strategy_class).to eq(OmniAuth::Strategies::OpenIDConnect)
    end
  end

  describe 'OIDC basic authentication flow' do
    let(:protected_resource_path) { '/oauths' }

    context 'when an account holder accesses a protected resource on the local service' do
      it 'redirects to the OIDC provider passing the protected resource url' do
        binding.pry
        # get '/accounts/auth/openid_connect'
        get protected_resource_path
        # get 'account/openid_connect/omniauth/authorize'
        # expect(response).to redirect_to(openid_connect_omniauth_authorize_path, params: { origin: protected_resource_path })
        # expect(response).to redirect_to('/')
        expect(response).to redirect_to(account_openid_connect_omniauth_authorize_path)
      end
    end
  end
end
