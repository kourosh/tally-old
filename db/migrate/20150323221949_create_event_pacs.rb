class CreateEventPacs < ActiveRecord::Migration
  def change
    create_table :event_pacs do |t|
      t.references :pac, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
