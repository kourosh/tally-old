class Pac < ActiveRecord::Base
  has_many :pac_pols, dependent: :destroy
  has_many :pols, through: :pac_pols
end
