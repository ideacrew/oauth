class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :openid_connect

  def openid_connect
    binding.pry
    super
  end

  def passthru
    binding.pry
    super
  end

  def failure
    redirect_to root_path
  end
end
