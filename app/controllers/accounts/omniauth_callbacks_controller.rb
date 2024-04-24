# frozen_string_literal: true

# {
#     'state' => 'f7ca6ea1fd9a068888a0d39f84f9d400',
#     'session_state' => '38178d98-c406-43d2-ab7e-d6165bcb8b7e',
#     'iss' => 'http://0.0.0.0:8180/realms/ideacrew',
#     'code' =>
#       '7bbeac3b-aeda-4d00-b586-245362042f85.38178d98-c406-43d2-ab7e-d6165bcb8b7e.736c6299-a9c7-41fa-87fb-77481b120ca8',
#     'controller' => 'accounts/omniauth_callbacks',
#     'action' => 'openid_connect'
#   }

class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :openid_connect

  # Sign in an account holder using OAuth2 OpenidConnect protocol
  def openid_connect
    id_token = request.env['omniauth.auth'].& symbolize_keys!
    Rails.logger.debug(id_token)

    identity = Accounts::Identity.find_or_initialize_with_oidc(id_token)

    # new identity
    if identity.account.nil?
      # search for account by name
      # if account is nil, create the account
      # if account is present, another identity has claimed account name, new name needed
      #   else
      #   account name is available
    end

    # existing identity

    binding.pry

    @identity.assign_attributes(
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name
    )

    retrieve_account

    @identity.save!
    sign_in_account
  end

  def failure
    redirect_to root_path
  end
end

private

def retrieve_account
  account_by_name = Account.find_or_initialize_by(name: @identity.name)
  @account = @identity.account || current_account || account_by_name

  # TODO: Ensure that the account is not already linked to the identity
  @account.identities << @identity

  return unless @account.new_record?

  @account.write_attributes(confirmed_at: Time.now.utc, email: @identity.email)
end

def sanitize_id_token_attrs
  return {} unless @auth
  {
    kind: @auth.provider || '',
    provider: @auth.provider || '',
    uid: @auth.uid || '',
    name: @auth.info.name || '',
    reason: @errors || ''
  }
end
