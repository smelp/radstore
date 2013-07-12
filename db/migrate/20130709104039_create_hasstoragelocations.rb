class CreateHasstoragelocations < ActiveRecord::Migration
  def change
    create_table :hasstoragelocations do |t|
      t.references :storagelocation
      t.references :batch
      t.integer :amount
      t.integer :batchType

      t.timestamps
    end
  end
end
