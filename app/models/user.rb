class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :events, through: :transactions
	has_many :transactions
  has_many :comments, as: :commentable
  has_many :comments
  has_many :favorites, as: :favorited
  has_many :favorites

	before_create :set_auth_token
	# geocoded_by :full_street_address
	# after_validation :geocode
	# acts_as_mappable :lat_column_name => :latitude,
	# :lng_column_name => :longitude
	# has_secure_password

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true


	def set_auth_token
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
