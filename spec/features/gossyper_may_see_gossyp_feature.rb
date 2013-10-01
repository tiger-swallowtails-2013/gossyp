require 'spec_helper'

describe "Gossyper may view gossyp", type: :feature do
  let!(:gossyps) {
    3.times.map do
      create_random_gossyp
    end
  }
  # I'm using let! because I want to ensure this code gets ran immediately
  context "when logged in" do
    before do
      login_as(create_gossyper)
      visit '/'
    end
    it "shows all the gossyps titles on the home page" do
      gossyps.each do |gossyp|
        expect(page).to have_content(gossyp.title)
      end
    end
    it "shows the gossyp body on the gossyp show page" do
      gossyp = gossyps.pop
      click_on gossyp.title
      expect(page).to have_content(gossyp.body)
    end
  end

  context "when not logged in" do
    it "shows no gossyp on the home page" do
      visit '/'

      gossyps.each do |gossyp|
        expect(page).not_to have_content(gossyp.title)
      end
    end
    it "prevents guests from even visiting a gossyp show page"
  end
end
