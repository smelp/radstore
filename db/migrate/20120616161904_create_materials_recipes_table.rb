class CreateMaterialsRecipesTable < ActiveRecord::Migration
  def up
    create_table :materials_recipes, :id => false do |t|
        t.references :material
        t.references :recipe
    end
    add_index :materials_recipes, [:material_id, :recipe_id], :unique => true
    add_index :materials_recipes, :recipe_id, :unique => false
  end

  def self.down
    drop_table :materials_recipes
  end
end
