class AddPriceToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :price, :decimal, default: 0
  end
end
