class AddSocialMediaColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :social_media_copy, :string
  end
end
