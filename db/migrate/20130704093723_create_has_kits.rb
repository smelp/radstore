class CreateHasKits < ActiveRecord::Migration
  def change
    create_table :haskits do |t|
      t.integer :ownerType
      t.integer :productID
      t.integer :kitID
      t.integer :volume
      t.integer :amount
      t.integer :fromStorage

      t.timestamps
    end
  end
end
