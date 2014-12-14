class AddPolRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :pol, index: true
  end
end
