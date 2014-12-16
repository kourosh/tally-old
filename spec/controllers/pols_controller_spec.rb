require 'rails_helper'

RSpec.describe PolsController, :type => :controller do
	describe "GET /pols/:id.json" do
	 	render_views
	  
	  context "all politcian's events" do
	    it "returns the politician's events" do
	    	pol = create(:pol)
	    	pol_event_headlines= []
	    	5.times do
	    		pol_event_headlines << create(:event, pol_id: pol.id).headline
	    	end
	    	get :show, id: pol.id, format: :json
	    	all_pol_event_headlines = JSON.parse(response.body).collect{|e| e["headline"]}
	    	expect(all_pol_event_headlines).to match_array(pol_event_headlines)
	    end
	  end
  end
end
