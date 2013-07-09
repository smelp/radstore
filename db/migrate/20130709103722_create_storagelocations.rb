class CreateStoragelocations < ActiveRecord::Migration
  def change
    create_table :storagelocations do |t|
      t.string :name
      t.string :info
      t.references :huslab

      t.timestamps
    end
  end
end
