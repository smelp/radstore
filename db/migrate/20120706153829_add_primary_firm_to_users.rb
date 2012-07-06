class AddPrimaryFirmToUsers < ActiveRecord::Migration
  def up
    add_column :users, :primary_firm_id, :integer
  end
  
  def down
    remove_column :users, :primary_firm_id
  end
end
