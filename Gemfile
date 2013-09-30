source 'https://rubygems.org'


gem 'sinatra'
gem 'omniauth'
gem 'omniauth-twitter'

# By grouping our testing gems in development and test we prevent them from
# being installed on Heroku.
#
# http://bundler.io/v1.3/groups.html
group :development, :test do
  gem 'rspec'
  gem 'capybara'

  # This allows us to set environment variables like oauth secrets
  # without checking them into our public repository
  gem 'dotenv'
end
