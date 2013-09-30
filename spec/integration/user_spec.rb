require 'spec_helper'
describe User do
  describe ".from_auth_hash" do
    context "when the user does not yet exist" do
      it "creates a new user with the provider uid" do
        User.from_auth_hash({
          uid: 12345
        })
        expect(User.find_by(twitter_uid: 12345)).not_to be_nil


      end
    end
  end
end
