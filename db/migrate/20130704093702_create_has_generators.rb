class CreateHasGenerators < ActiveRecord::Migration
  def change
    create_table :hasgenerators do |t|
      t.integer :ownerType
      t.integer :productID
      t.integer :generatorID

      t.timestamps
    end
  end
end
