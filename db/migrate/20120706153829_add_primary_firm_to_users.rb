class AddPrimaryFirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_firm_id, :integer
  end

end
