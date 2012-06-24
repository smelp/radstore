class AddPriceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :price, :float, default: 0
  end
end
