class Comment < ActiveRecord::Base
  belongs_to :commentable
  belongs_to :user
  has_many :subcomments, class_name: "Comment",
                         foreign_key: "child_id"

  belongs_to :child, class_name: "Comment"

end
