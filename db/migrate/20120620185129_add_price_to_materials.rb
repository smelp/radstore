class AddPriceToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :price, :float, default: false
  end
end
