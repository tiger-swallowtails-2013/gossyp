describe 'Gossyper may star gossyp', type: :feature do
  context "when the gossyp is not yet starred" do
    it "stars the gossyp!" do
      gossyper = create_gossyper
      gossyp = create_random_gossyp
      login_as gossyper

      click_on "star_gossyp_#{gossyp.id}"

      expect(page).to have_content "You've starred #{gossyp.title}!"

      within "#gossyp_#{gossyp.id}" do
        expect(page).to have_button "Unstar"
      end
    end
  end

  context "when the gossyp is starred" do
    it "unstars the gossyp" do
      gossyper = create_gossyper
      gossyp = create_random_gossyp
      gossyp.toggle_star!(gossyper)

      login_as gossyper

      click_on "star_gossyp_#{gossyp.id}"
      expect(page).to have_content "You've unstarred #{gossyp.title}!"

      within "#gossyp_#{gossyp.id}" do
        expect(page).to have_button "Star"
      end
    end
  end
end
