class Pol < ActiveRecord::Base
	has_many :events


  def fullname
    [firstname, lastname].join(' ')
  end
end
