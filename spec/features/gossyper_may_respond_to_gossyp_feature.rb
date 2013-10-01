require 'spec_helper'

describe "Gossyper may respond to gossyp", type: :feature do
  context "when the response is valid" do
    it "saves the response" do
      gossyp = create_random_gossyp
      gossyper = create_gossyper
      login_as gossyper
      visit "/gossyps/#{gossyp.id}"
      fill_in 'response[body]', with: "My happiness doth abound"
      click_on "Add Response"

      expect(page).to have_content "My happiness doth abound"
      expect(gossyp.responses.last.body).to eq "My happiness doth abound"
    end
  end

  context "when the response is not valid" do
    it "does not save the response"
  end
end
