describe "Gossyper may create discussion", type: :feature do
  context "when logged in" do
    context "when gossyper provides all required fields" do
      it "Allows a gossyper to create a new discussion"
    end

    context "when the user does not provide all required fields" do
      it "Informs the gossyper which fields they failed to supply"
    end
  end

  context "when not logged in" do
    it "does not allow a gossyper to create a discussion"
  end
end
