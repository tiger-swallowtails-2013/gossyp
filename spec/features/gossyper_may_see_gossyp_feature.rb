require 'spec_helper'

describe "Gossyper may view gossyp", type: :feature do
  context "when logged in" do
    it "shows all the gossyps titles on the home page" do
      login_as(create_gossyper)
      gossyps = 3.times.map do
        create_random_gossyp
      end
      visit '/'
      gossyps.each do |gossyp|
        expect(page).to have_content(gossyp.title)
      end
    end
    it "shows the gossyp body on the gossyp show page"
  end

  context "when not logged in" do
    it "shows no gossyp on the home page"
    it "prevents guests from even visiting a gossyp show page"
  end
end
