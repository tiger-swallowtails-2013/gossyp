require 'spec_helper'

describe Gossyp do
  it { should have_many :reactions }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe "#toggle_star!" do
    context "when the user has not yet starred the gossyp" do
      it "adds a star" do

        gossyper = create_gossyper
        gossyp = create_random_gossyp
        gossyp.toggle_star! gossyper

        expect(gossyper).to have_starred gossyp
      end
    end
    context "when the user has already starred the gossyp" do
      it "removes the star"
    end

  end
end
