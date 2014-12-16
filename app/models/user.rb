class User < ActiveRecord::Base
	before_create :set_auth_token
	geocoded_by :full_street_address
	after_validation :geocode

	def full_street_address
		self.full_street_address = "#{user_street_address} #{user_city}, #{user_state} #{user_zip}"
	end

	private

		def set_auth_token
			return if auth_token.present?
			self.auth_token = generate_auth_token
		end

		def generate_auth_token
			loop do
				token = SecureRandom.hex
				break token unless self.class.exists?(auth_token: token)
			end
		end
	
end
