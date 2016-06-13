source 'https://rubygems.org'


gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "figaro"
gem "faraday"
gem 'active_model_serializers', github: "rails-api/active_model_serializers"
gem 'responders'
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem 'aws-sdk', '~> 2.3'
gem "bootstrap", "~> 4.0.0.alpha3"
gem 'exifr', :git => 'git://github.com/remvee/exifr.git'
gem 'omniauth-facebook'

group :production do
  gem "rails_12factor"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.4'
  gem "vcr"
  gem "simplecov", require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem "factory_girl_rails", "~> 4.0"  
  gem "capybara"
  gem "launchy"
  gem "webmock"
  gem "mocha"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

