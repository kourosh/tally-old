class AddAndRemoveColFromPols < ActiveRecord::Migration
  def change
    add_column :pols, :current_office, :string
    add_column :pols, :personal_website, :string
    add_column :pols, :primary_donation_website, :string
    remove_column :pols, :in_office
  end
end
