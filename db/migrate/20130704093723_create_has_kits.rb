class CreateHasKits < ActiveRecord::Migration
  def change
    create_table :haskits do |t|
      t.integer :ownerType
      t.integer :productID
      t.integer :kitID

      t.timestamps
    end
  end
end
