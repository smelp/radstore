class AddStateToBills < ActiveRecord::Migration
  def change
    add_column :bills, :state, :string, default: "Tilattu"
  end
end
