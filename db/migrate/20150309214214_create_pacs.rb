class CreatePacs < ActiveRecord::Migration
  def change
    create_table :pacs do |t|
      t.string :committee_id
      t.string :committee_name
      t.string :affiliated_party

      t.timestamps
    end
  end
end
