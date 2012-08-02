class CreateBakeryorderrecipes < ActiveRecord::Migration
  def change
    create_table :bakeryorderrecipes do |t|
        t.references :recipe
        t.references :bakeryorder
        t.decimal :amount, default: 0
        t.decimal :price, default: 0
        
        t.timestamps
    end
    
    add_index :bakeryorderrecipes, [:recipe_id, :bakeryorder_id], :unique => true
    add_index :bakeryorderrecipes, :bakeryorder_id, :unique => false
  end
end
