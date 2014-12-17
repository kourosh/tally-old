class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :event
	
	def pol_fullname
		pol.try(:fullname)
	end
end
