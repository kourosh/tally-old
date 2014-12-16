class Pol < ActiveRecord::Base
	has_many :events

	# def fullname
	# 	"#{firstname} #{lastname}"
	# end
	
	before_save :make_fullname

	def make_fullname
		self.fullname = "#{firstname} #{lastname}"
	end

end
