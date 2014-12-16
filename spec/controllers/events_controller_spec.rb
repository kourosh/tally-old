require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
	describe "GET /events.json" do
	 	render_views
	  
	  context 'all events' do
	    it 'returns the events' do
	    	event_headlines= []
	    	5.times do
	    		event_headlines << create(:event).headline
	    	end
	    	get :index, format: :json
	    	all_event_headlines = JSON.parse(response.body).collect{|e| e["headline"]}
	    	expect(all_event_headlines).to match_array(event_headlines)
	    end
	  end
  end
end
