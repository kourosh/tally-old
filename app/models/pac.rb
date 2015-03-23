class Pac < ActiveRecord::Base
  has_many :pac_pols, dependent: :destroy
  has_many :pols, through: :pac_pols
  has_many :event_pacs, dependent: :destroy
  has_many :events, through: :event_pacs
end
