require 'spec_helper'

describe "Gossyper may react to gossyp", type: :feature do
  let(:gossyp) { create_random_gossyp }
  let(:gossyper) { create_gossyper }
  before {
      login_as gossyper
      visit "/gossyps/#{gossyp.id}"
  }
  context "when the reaction is valid" do
    it "saves the reaction" do
      fill_in 'reaction[body]', with: "My happiness doth abound"
      click_on "Add Reaction"

      expect(page).to have_content "My happiness doth abound"
      expect(gossyp.reactions.last.body).to eq "My happiness doth abound"
    end
  end

  context "when the reaction is not valid" do
    it "does not save the reaction" do
      click_on "Add Reaction"
      expect(page).to have_content "Body can't be blank"
      expect(gossyp.reactions).to be_empty
    end
  end
end
