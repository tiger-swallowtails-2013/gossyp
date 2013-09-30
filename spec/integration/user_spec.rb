require 'spec_helper'
describe User do
  describe ".from_auth_hash" do
    it "returns a user with a twitter_uid which matches the passed in uid" do
      user = User.from_auth_hash({
        uid: 12345
      })
      expect(user.twitter_uid).to eql(12345)
    end

    context "when the user does not yet exist" do
      it "creates a new user with the provider uid" do
        User.from_auth_hash({
          uid: 12345
        })
        expect(User.find_by(twitter_uid: 12345)).not_to be_nil
      end
    end

    context "when the user does exist" do
      it "does not create a new user" do
        User.create(twitter_uid: 45677)
        expect {
          User.from_auth_hash({
            uid: 45677
          })
        }.not_to change { User.count }
      end
    end
  end
end
