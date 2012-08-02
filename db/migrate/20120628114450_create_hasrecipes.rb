class CreateHasrecipes < ActiveRecord::Migration
  def change
    create_table :hasrecipes do |t|
      t.integer :recipe_id
      t.integer :subrecipe_id
      t.decimal :amount, default: 0
        
      t.timestamps
    end
  end
end
