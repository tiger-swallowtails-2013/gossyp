require 'spec_helper'
describe User do
  describe ".from_auth_hash" do
    let(:auth_hash) {
      {
        uid: uid,
        info: {
          name: name
        }
      }
    }
    let(:uid) { 12345 }
    let(:name) { "James Dean" }

    subject(:user) { User.from_auth_hash(auth_hash) }

    it "returns a user with a twitter_uid which matches the passed in uid" do
      expect(user.twitter_uid).to eql(12345)
    end

    it "sets the users full_name to the auth hashes[:info][:name]" do
      expect(user.full_name).to eql("James Dean")
    end

    context "when the user does not yet exist" do
      it "creates a new user with the provider uid" do
        # Because `let`s are lazily evaluated, if I want to call
        # user.from_auth_hash I need to call `user`
        user
        expect(User.find_by(twitter_uid: 12345)).not_to be_nil
      end
    end

    context "when the user does exist" do
      it "does not create a new user" do
        User.create(twitter_uid: uid)
        expect {
          user
        }.not_to change { User.count }
      end
    end
  end
end
