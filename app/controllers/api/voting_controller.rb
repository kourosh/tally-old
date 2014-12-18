module API
	class VotingController < ApplicationController
		def support
			user = User.find(params[:uid])
			event = Event.find(params[:eid])
			if user.balance == nil 
				user.balance = 100
			end
			if event.balance_for == nil
				event.balance_for = 0
			end
			if user.balance > 0
				user.balance += -5
				event.balance_for += 5
				user.save
				event.save
				respond_to do |format|
					format.json { head :no_content }
				end
			else
				respond_to do |format|
					format.json { render :json => { value: "YOU RAN OUT OF MONEY BRO" } }
				end
			end
		end
		def oppose
			user = User.find(params[:uid])
			event = Event.find(params[:eid])
			if user.balance == nil
				user.balance = 100
			end
			if event.balance_against == nil
				event.balance_against = 0
			end
			if user.balance > 0
				user.balance += -5
				event.balance_against += 5
				user.save
				event.save
				respond_to do |format|
					format.json { head :no_content }
				end
			else
				respond_to do |format|
					format.json { render :json => { value: "YOU RAN OUT OF MONEY BRO" } }
				end
			end
		end
	end
end
