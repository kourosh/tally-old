class Event < ActiveRecord::Base
	belongs_to :pol

	def pol_fullname
		pol.try(:lastname)
	end

	def pol_fullname=(lastname)
		self.pol = Pol.find_by_name(lastname) if lastname.present?
	end

end
