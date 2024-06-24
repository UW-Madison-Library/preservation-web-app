# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.8.3'
# Use SCSS for stylesheets
gem 'dartsass-rails', '~> 0.5.0'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2'

gem 'importmap-rails', '~> 1.2', '>= 1.2.3'
gem 'stimulus-rails', '~> 1.3', '>= 1.3.3'
gem 'turbo-rails', '~> 1.5', '>= 1.5.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.12.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.18.3', require: false

# Ruby client for the Preservation Service, generated from external api definitions
# https://github.com/UW-Madison-Library/preservation-api/blob/main/openapi/manager-external-api.yml
gem 'preservation_manager', path: 'vendor/preservation_manager'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.14.2'

  # Use Puma as the app server
  gem 'puma', '~> 6.4.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.1'
  # Display performance information such as SQL time and flame graphs for each request in your
  # browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler', '~> 2.0'

  gem 'listen', '~> 3.9.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.2.1'
end

group :test do
  gem 'rspec-rails', '~> 6.1.2'

  gem 'rubocop', '~> 1.63.5', require: false
  gem 'rubocop-rails', '~> 2.25.0', require: false
  gem 'rubocop-rspec', '~> 2.29.2', require: false
end
