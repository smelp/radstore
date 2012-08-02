class AddAccountNumberAndAddressToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :address, :string
    add_column :firms, :account_number, :string
  end
end
