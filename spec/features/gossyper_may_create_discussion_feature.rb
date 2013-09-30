require 'spec_helper'

describe "Gossyper may creete discussion", type: :feature do
  context "when logged in" do
    context "when gossyper provides all required fields" do
      it "Allows a gossyper to create a new discussion"
    end

    context "when the user does not provide all required fields" do
      it "Informs the gossyper which fields they failed to supply"
    end
  end

  context "when not logged in" do
    it "does not allow a gossyper to create a discussion" do
      visit '/gossyps/new'
      expect(current_url).to eql 'http://www.example.com/'
    end
  end
end
