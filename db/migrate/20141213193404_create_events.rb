class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :headline
      t.string :source

      t.timestamps
    end
  end
end
