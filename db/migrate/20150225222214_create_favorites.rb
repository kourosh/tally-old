class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      # t.integer :favorited_id
      t.references :favorited, polymorphic: true, index: true
      t.string  :favorited_type
      t.references :user, index: true

      t.timestamps

      # add_index :favorites, :favorited_id
    end
  end
end
