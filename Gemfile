source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'mongoid', '~> 8.1.1'

# OmniAuth is a flexible authentication system utilizing Rack middleware.
gem 'omniauth'
# gem 'omniauth-keycloak'
# A Devise-friendly OmniAuth stretegy for OpenID Connect
gem 'omniauth_openid_connect'
gem 'omniauth-rails_csrf_protection'
gem 'devise'
gem 'listen'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem 'database_cleaner-mongoid'
  # Manage translation and localization with static analysis, for Ruby i18n
  gem 'i18n-tasks'

  gem 'mongoid-rspec'

  gem 'pry-byebug', platform: :mri

  gem 'rspec-rails', '~> 6.0'

  gem 'rubocop', require: false
  gem 'rubocop-changed'
  gem 'rubocop-git', require: false
  gem 'rubocop-md', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'ruby-debug-ide', require: false
  # gem 'debase', require: false

  # CRuby parser-based syntac tree generator.  Use with VSCode ruby-syntax-tree plugin to enable auto formatting
  gem 'syntax_tree'

  # Yard Doc developer documentation support gems
  gem 'github-markup', platform: :mri
  gem 'redcarpet', platform: :mri
  gem 'yard', require: false
end

group :development do
  # Patch-level verification for Bundler
  gem 'bundler-audit'

  gem 'ruby-lsp-rails'

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  # gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
