class Favorite < ActiveRecord::Base
  belongs_to :favorited
  belongs_to :user
end
