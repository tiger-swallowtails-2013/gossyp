require 'spec_helper'

describe "Gossyper may view gossyp", type: :feature do
  context "when logged in" do
    it "shows all the gossyps titles on the home page"
    it "shows the gossyp body on the gossyp show page"
  end

  context "when not logged in" do
    it "shows no gossyp on the home page"
    it "prevents guests from even visiting a gossyp show page"
  end
end
