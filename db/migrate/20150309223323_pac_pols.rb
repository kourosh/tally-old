class PacPols < ActiveRecord::Migration
  def change
    create_table :pac_pols do |t|
      t.references :pac, index: true
      t.references :pol, index: true

      t.timestamps
    end
  end
end
