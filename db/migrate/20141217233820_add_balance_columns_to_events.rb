class AddBalanceColumnsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :balance_for, :float 
  	add_column :events, :balance_against, :float
  end
end
