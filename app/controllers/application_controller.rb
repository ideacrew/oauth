class ApplicationController < ActionController::Base
  before_action :authenticate_account!
  
  def authenticate_account!
    binding.pry
    super
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
