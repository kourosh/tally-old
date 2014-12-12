class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :user_first_name
    	t.string :user_last_name
    	t.string :user_street_address
    	t.string :user_city
    	t.string :user_street_address
    	t.integer :user_zip
    	t.string :user_phone
    	t.string :occupation
    	t.string :employer_name
    	t.boolean :unemployed_or_retired

      t.timestamps
    end
  end
end
