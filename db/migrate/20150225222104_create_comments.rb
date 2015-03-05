class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      # t.integer :commentable_id
      t.references :commentable, polymorphic: true, index: true
      t.string  :commentable_type
      t.references :user, index: true
      t.references :child, index: true

      t.timestamps

      # add_index :comments, :commentable_id
    end
  end
end