require 'spec_helper'

# If we want to use capybara without rails, we need to specify the
# type: :feature option for the rspec describe block
describe "Guest logs in with twitter", type: :feature do
# https://github.com/jnicklas/capybara#using-capybara-with-rspec

  let(:twitter_user_info) {
    # This is our fake user data
    {
      name: "Zee Spencer",
      nickname: "zspencer",
    }
  }

  let(:twitter_uid) {
    # the uid is the identifier that twitter uses in house to keep track of who
    # people are.

    12345
  }

  def login_with_twitter
    visit '/'
    click_on 'Login with Twitter!'
  end

  before do
    # In order to test twitter without hitting the real twitter, we want to
    # simulate how twitter responds to omniauth.  We do this by leveraging
    # omniauth's mock toolset to provide fake twitter responses. This is
    # reasonable because we can trust that the omniauth and omniauth twitter
    # gems will do their job.


    # We want to provide a reasonable response from twitter that we can use for
    # testing.  It should match what omniauth-twitter declares is the twitter
    # authentication hash. I recommend the following fields: uid, and info

    OmniAuth.config.add_mock(:twitter, {:uid => twitter_uid, :info => twitter_user_info })

    # https://github.com/intridea/omniauth/wiki/Integration-Testing#omniauthconfigmock_auth
    # https://github.com/arunagw/omniauth-twitter#authentication-hash


  end

  it "redirects them to the home page" do
    login_with_twitter
    expect(current_url).to eq "http://www.example.com/"
  end

  it "displays a welcome! message" do
    login_with_twitter
    expect(page).to have_content("Welcome #{twitter_user_info["name"]}")
  end

  context "when they have not logged in before" do
    it "creates a new user with their uid" do
      expect {
        login_with_twitter
      }.to change { User.count }.by(1)
      expect(User.find_by(twitter_uid: twitter_uid)).not_to be_nil
    end
  end
end
