class CreateHasstoragelocations < ActiveRecord::Migration
  def change
    create_table :hasstoragelocations do |t|
      t.references :storagelocation
      t.references :batch
      t.integer :amount
      t.string :batchType

      t.timestamps
    end
  end
end
