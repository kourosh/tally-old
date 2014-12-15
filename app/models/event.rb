class Event < ActiveRecord::Base
	belongs_to :pol

	def pol_fullname
		pol.try(:fullname)
	end

	def pol_fullname=(fullname)
		self.pol = Pol.find_by_fullname(fullname) if fullname.present?
	end

end
