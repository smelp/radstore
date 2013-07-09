class CreateHasstoragelocations < ActiveRecord::Migration
  def change
    create_table :hasstoragelocations do |t|
      t.references :storagelocation
      t.references :item
      t.integer :item_type
      t.integer :amount

      t.timestamps
    end
  end
end
