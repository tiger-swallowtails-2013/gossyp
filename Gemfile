source 'https://rubygems.org'


gem 'sinatra'
gem 'sinatra-activerecord'
gem 'pg'

gem 'omniauth'
gem 'omniauth-twitter'

# I chose rack-flash over sinatra-flash because sinatra-flash hadn't had a
# commit in years.
gem 'rack-flash3'

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
