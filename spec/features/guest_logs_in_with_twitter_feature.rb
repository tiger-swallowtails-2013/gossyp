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

# Turn on test mode fo omniauth so it doesn't actually hit twitter
OmniAuth.config.test_mode = true
# https://github.com/intridea/omniauth/wiki/Integration-Testing


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

  it "displays a welcome! message" do
    # In order to test twitter without hitting twitter, we want to simulate how
    # twitter responds to omniauth.  We do this by leveraging omniauth's mock
    # toolset to provide fake twitter responses. This is reasonable because we
    # can trust that the omniauth and omniauth twitter gems will do their job.


    # This is our fake user data
    twitter_user_info = {
      name: "Zee Spencer",
      nickname: "zspencer",
    }

    # We want to provide a reasonable response from twitter that we can use for testing.
    # It should match what omniauth-twitter declares is the twitter authentication hash

    # the uid is the identifier that twitter uses in house to keep track of who people are.
    OmniAuth.config.add_mock(:twitter, {:uid => '12345', :info => twitter_user_info })

    # https://github.com/intridea/omniauth/wiki/Integration-Testing#omniauthconfigmock_auth
    # https://github.com/arunagw/omniauth-twitter#authentication-hash

    visit '/'
    click_on 'Login with Twitter!'

    expect(page).to have_content("Welcome #{twitter_user_info["name"]}")
  end

  context "when they have not logged in before" do
    it "creates a new user"
  end
  context "when they have logged in before" do
    it "does not create a new user"
  end
end
