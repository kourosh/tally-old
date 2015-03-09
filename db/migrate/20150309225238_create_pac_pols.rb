class CreatePacPols < ActiveRecord::Migration
  def change
    create_table :pac_pols do |t|

      t.timestamps
    end
  end
end
