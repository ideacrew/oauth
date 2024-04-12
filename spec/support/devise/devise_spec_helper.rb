require 'devise'

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.before(:each, type: :request) { host! 'localhost:3000' }

  ## Other potential Devise helpers:
  # config.include Devise::Test::ControllerHelpers, type: :view
  # config.include Devise::Test::IntegrationHelpers, type: :feature
end

module DeviseSpecHelper
  def self.included(base)
    base.before { Warden.test_mode! }
    base.after { Warden.test_reset! }
  end

  def sign_in(resource_or_scope, resource = nil)
    binding.pry
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    login_as(resource, scope: scope)
  end
end

RSpec.configure { |config| config.include DeviseSpecHelper, type: :request }
