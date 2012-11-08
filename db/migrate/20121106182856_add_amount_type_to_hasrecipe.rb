class AddAmountTypeToHasrecipe < ActiveRecord::Migration
  def change
    add_column :hasrecipes, :amount_type, :string, :default => 'units'
  end
end
