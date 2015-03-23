class AddSupportToEventPacs < ActiveRecord::Migration
  def change
    add_column :event_pacs, :support, :boolean
  end
end
