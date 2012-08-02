class AddAddressToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :address, :string
  end
end
