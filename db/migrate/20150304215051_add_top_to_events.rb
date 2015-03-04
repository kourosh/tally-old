class AddTopToEvents < ActiveRecord::Migration
  def change
    add_column :events, :top, :boolean, :default => false
  end
end
