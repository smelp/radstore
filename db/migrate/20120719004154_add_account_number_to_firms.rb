class AddAccountNumberToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :account_number, :string
  end
end
