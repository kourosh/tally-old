class EventPac < ActiveRecord::Base
  belongs_to :pac
  belongs_to :event
end
