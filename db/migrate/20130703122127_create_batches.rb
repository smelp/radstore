class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :batchNumber
      t.integer :amount
      t.references :substance

      t.timestamps
    end
    add_index :batches, :substance_id
  end
end
