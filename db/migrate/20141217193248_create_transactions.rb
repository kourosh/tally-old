class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.references :user
    	t.references :event
    	t.float :amount
    	t.boolean :support

      t.timestamps
    end
  end
end
