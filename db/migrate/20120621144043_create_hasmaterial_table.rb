class CreateHasmaterialTable < ActiveRecord::Migration
  def up
    create_table :hasmaterials do |t|
        t.references :material
        t.references :recipe
        t.float :amount, default: 0
        
        t.timestamps
    end
    
    add_index :hasmaterials, [:material_id, :recipe_id], :unique => true
    add_index :hasmaterials, :recipe_id, :unique => false
  end

  def self.down
    drop_table :hasmaterials
  end
end
