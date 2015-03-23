class Event < ActiveRecord::Base
	belongs_to :pol
	has_many :users, through: :transactions
	has_many :transactions
	has_many :comments, as: :commentable
	has_many :favorites, as: :favorited
	has_many :event_pacs, dependent: :destroy
  has_many :pacs, through: :event_pacs
	# before_create :set_auth_token

	def pol_fullname
		pol.try(:fullname)
	end

	def pol_fullname=(fullname)
		self.pol = Pol.find_by_fullname(fullname) if fullname.present?
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
