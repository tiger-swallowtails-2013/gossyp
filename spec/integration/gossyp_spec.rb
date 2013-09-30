require 'spec_helper'

describe Gossyp do
  let(:gossyp) { Gossyp.new }
  describe "validations" do
    before { gossyp.valid? }
    it "requires a title" do
      expect(gossyp.errors).to have_key(:title)
    end

    it "requires a body" do
      expect(gossyp.errors).to have_key(:body)
    end
  end
end
