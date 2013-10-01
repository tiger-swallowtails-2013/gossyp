module FeatureLoginHelper
  def login_as(user)
    OmniAuth.config.add_mock(:twitter, {
      uid: user.twitter_uid,
      :info => { :name => user.full_name }
    })

    visit '/auth/twitter'
  end
end
