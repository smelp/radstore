class CreateHasGenerators < ActiveRecord::Migration
  def change
    create_table :hasgenerators do |t|
      t.integer :ownerType
      t.integer :productID
      t.integer :generatorID
      t.integer :volume
      t.integer :amount
      t.integer :fromStorage

      t.timestamps
    end
  end
end
