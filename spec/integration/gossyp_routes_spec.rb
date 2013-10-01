require 'spec_helper'

describe 'post /gossyps' do
  include RouteHelper

  let(:gossyp_attributes) {
    random_gossyp_attributes
  }

  context "when not logged in" do
    it "responds with a 403" do
      post '/gossyps', { gossyp: gossyp_attributes }
      expect(last_response.status).to eql 403
    end
  end

  context "when logged in" do
    it "assigns the created gossyp to the logged in user" do
      gossyper = create_gossyper
      post '/gossyps', {
        gossyp: gossyp_attributes
      }, { 'rack.session' => { user_id: gossyper.id } }

      expect(gossyper.gossyps.last.title).to eq gossyp_attributes[:title]
    end
  end
end

describe 'get /gossyps/new' do
  include RouteHelper

  context "when not logged in" do
    it "responds with a 403" do
      get '/gossyps/new'
      expect(last_response.status).to eql 403
    end
  end
end
