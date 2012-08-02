class AddPriceToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :price, :decimal, default: 0
  end
end
