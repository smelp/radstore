class AddCoverageRoRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :coverage, :decimal, default: 0
  end
end
