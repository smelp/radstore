class AddReferenceNumberToBills < ActiveRecord::Migration
  def change
    add_column :bills, :reference_number, :integer, default: 0
  end
end
