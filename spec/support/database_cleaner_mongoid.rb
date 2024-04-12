# frozen_string_literal: true

require 'database_cleaner-mongoid'

# Configure to clean database once at start of each rspec test run
# Also requires following in rails_helper to work:
#   config.use_transactional_fixtures = false
RSpec.configure do |config|
  # DatabaseCleaner[:mongoid].strategy = :deletion, { except: ["users"] }
  config.before(:suite) { DatabaseCleaner[:mongoid].strategy = [:deletion] }
  config.before(:suite) { DatabaseCleaner[:mongoid].clean_with(:deletion) }

  config.before(:each) { DatabaseCleaner[:mongoid].start }
  config.after(:each) { DatabaseCleaner[:mongoid].clean }

  config.before(:each, js: true) { DatabaseCleaner.strategy = [:truncation] }
  # config.around(:each) { |example| DatabaseCleaner[:mongoid].cleaning { example.run } }

  # config.before(:suite) do
  #   DatabaseCleaner[:mongoid].strategy = [:deletion]

  #   # Only delete the "users" collection.
  #   DatabaseCleaner[:mongoid].strategy = :deletion, { only: ['users'] }

  #   # Delete all collections except the "users" collection.
  #   DatabaseCleaner[:mongoid].strategy = :deletion, { except: ['users'] }
  # end
end
