require 'spec_helper'

describe Gossyp do
  it { should have_many :responses }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
