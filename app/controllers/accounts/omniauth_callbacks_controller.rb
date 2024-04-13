class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :openid_connect

  def openid_connect
    binding.pry

    {
      "state"=>"ead5869b7f1761cb664bb0309bc3dbca",
      "session_state"=>"4ffc4396-a879-4b7e-b40b-63c37e99f1e0",
      "iss"=>"http://0.0.0.0:8180/realms/ideacrew",
      "code"=>"f9fa7c20-cb7b-471d-951b-103784081295.4ffc4396-a879-4b7e-b40b-63c37e99f1e0.736c6299-a9c7-41fa-87fb-77481b120ca8",
      "controller"=>"accounts/omniauth_callbacks",
      "action"=>"openid_connect"
    }
  end

  def passthru
    binding.pry
    super
  end

  def failure
    redirect_to root_path
  end
end
