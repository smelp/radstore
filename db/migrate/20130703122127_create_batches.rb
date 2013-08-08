class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :batchNumber
      t.date :expDate
      t.references :substance
      t.integer :qualityControl, :default => 7

      t.timestamps
    end
    add_index :batches, :substance_id
  end
end
