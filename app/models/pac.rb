class Pac < ActiveRecord::Base
  has_many :pac_pols
  has_many :pols, through: :pac_pols
end
