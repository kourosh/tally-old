class AddSupportToPacPols < ActiveRecord::Migration
  def change
    add_column :pac_pols, :support, :boolean
  end
end
