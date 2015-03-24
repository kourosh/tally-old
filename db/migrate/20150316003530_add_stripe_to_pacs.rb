class AddStripeToPacs < ActiveRecord::Migration
  def change
    add_column :pacs, :stripe_secret_key, :string
    add_column :pacs, :stripe_publishable_key, :string
    add_column :pacs, :stripe_user_id, :string
    add_column :pacs, :signup_token, :string
    add_column :pacs, :pac_email, :string
  end
end
