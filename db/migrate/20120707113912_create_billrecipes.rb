class CreateBillrecipes < ActiveRecord::Migration
  def change
    create_table :billrecipes do |t|
        t.references :recipe
        t.references :bakerybill
        t.float :amount, default: 0
        t.float :price, default: 0
        
        t.timestamps
    end
    
    add_index :billrecipes, [:recipe_id, :bakerybill_id], :unique => true
    add_index :billrecipes, :bakerybill_id, :unique => false
  end

end
