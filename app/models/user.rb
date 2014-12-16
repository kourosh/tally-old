class User < ActiveRecord::Base
	before_create :set_auth_token
	geocoded_by :full_street_address
	after_validation :geocode
	acts_as_mappable :lat_column_name => :latitude,
	:lng_column_name => :longitude


	def set_auth_token
		return if auth_token.present?
		self.auth_token = generate_auth_token
	end
	private
	def generate_auth_token
		loop do
			token = SecureRandom.hex
			break token unless self.class.exists?(auth_token: token)
		end
	end
	
end
