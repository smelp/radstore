class CreateClientRecipes < ActiveRecord::Migration
  def change
    create_table :clientrecipes do |t|
      t.integer :recipe_id
      t.integer :client_id
      t.decimal :price, default: 0
        
      t.timestamps
    end
  end
end
