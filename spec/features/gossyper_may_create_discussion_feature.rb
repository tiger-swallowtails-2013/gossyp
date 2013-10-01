require 'spec_helper'

describe "Gossyper may creete discussion", type: :feature do
  def create_gossyper
    require 'securerandom'
    User.create({
      twitter_uid: 1234,
      full_name: "Gossyper #{SecureRandom.hex(4)}"
    })
  end

  def login_as(user)
    OmniAuth.config.add_mock(:twitter, {
      uid: user.twitter_uid,
      :info => { :name => user.full_name }
    })

    visit '/auth/twitter'
  end
  context "when logged in" do
    let(:gossyper) { create_gossyper  }
    context "when gossyper provides all required fields" do
      it "Allows a gossyper to create a new discussion" do
        login_as gossyper
        click_on 'New Gossyp!'
        title = "Didja hear about ARRRSpec?!"
        fill_in 'Title', with: title
        fill_in 'Body', with: "It's a software pirates favorite testing framework!"

        expect {
          click_on "Spread the Gossyp!"
        }.to change { Gossyp.count }.by(1)
        expect(page).to have_content("You've started a Gossyp about #{title}")
        expect(gossyper.gossyps).to include Gossyp.last
      end
    end

    context "when the user does not provide all required fields" do
      it "Informs the gossyper which fields they failed to supply" do
        login_as gossyper
        click_on 'New Gossyp!'

        expect {
          click_on "Spread the Gossyp!"
        }.not_to change { Gossyp.count }

        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Body can't be blank")
        expect(current_url).to eql "http://www.example.com/gossyps"
      end
    end
  end

  context "when not logged in" do
    it "does not allow a gossyper to create a discussion" do
      visit '/gossyps/new'
      expect(current_url).to eql 'http://www.example.com/'
    end
  end
end
