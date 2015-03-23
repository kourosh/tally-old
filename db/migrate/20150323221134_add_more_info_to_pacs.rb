class AddMoreInfoToPacs < ActiveRecord::Migration
  def change
    add_column :pacs, :ideology, :string
    add_column :pacs, :address, :string
    add_column :pacs, :city, :string
    add_column :pacs, :state, :string
    add_column :pacs, :zip, :string
    add_column :pacs, :affiliated_candidate, :string
  end
end
