# We set the load path so we can avoid require_relative
$LOAD_PATH.unshift(File.expand_path('.'))
# File::expand_path - http://www.ruby-doc.org/core-2.0.0/File.html#method-c-expand_path
# $LOAD_PATH - http://www.ruby-doc.org/core-2.0/Kernel.html#method-i-require
# Array#unshift http://www.ruby-doc.org/core-2.0.0/Array.html#method-i-unshift

# We require our app so that we have access to Sinatra::Application for capybara
require 'gossyp'

require 'capybara/rspec'

# Tell capybara that we're testing your sinatra app
# https://github.com/jnicklas/capybara#setup
Capybara.app = Sinatra::Application

# If we want to use rspec without rails, we need to specify the
# type: :feature option for the rspec describe block
describe "Guest logs in with twitter", type: :feature do
# https://github.com/jnicklas/capybara#using-capybara-with-rspec

  it "redirects them to the home page" do
    visit '/'
    click_on 'Login with Twitter!'
    expect(current_url).to eq "http://www.example.com/"

    # This test is kind of a lame one,
    # But it's enough to get me started making the app work.
  end
  it "displays a welcome! message"

  context "when they have not logged in before" do
    it "creates a new user"
  end
  context "when they have logged in before" do
    it "does not create a new user"
  end
end
