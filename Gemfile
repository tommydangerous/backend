source "https://rubygems.org"

gem "rails", "4.2.0"

gem "active_model_serializers"
gem "activeadmin", git: "https://github.com/activeadmin/activeadmin"
gem "attr_extras"
gem "dotenv-rails"
gem "payload", require: "payload/railtie"
gem "pg"
gem "unicorn"
# gem "unicorn-rails"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "pry-byebug"
  gem "rspec-rails"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit", require: false
  gem "guard-livereload", require: false
  gem "license_finder", require: false
  gem "mina"
  gem "quiet_assets"
  gem "pry-rails"
  gem "railroady"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :test do
  # gem "capybara"
  # gem "capybara-webkit"
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "formulaic"
  gem "rspec-instafail", require: false
  gem "simplecov", require: false
  gem "shoulda", require: false
  gem "timecop"
end
