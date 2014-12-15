class Pol < ActiveRecord::Base
	has_many :events
	before_save :make_fullname

	def make_fullname
		self.fullname = "#{firstname} #{lastname}"
	end

end
