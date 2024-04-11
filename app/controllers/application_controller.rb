class ApplicationController < ActionController::Base
  before_action :authenticate_account!
  
  def authenticate_account!
    binding.pry
    super
  end
end
