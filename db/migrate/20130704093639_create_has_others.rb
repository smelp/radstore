class CreateHasOthers < ActiveRecord::Migration
  def change
    create_table :hasothers do |t|
      t.integer :ownerType
      t.integer :productID
      t.integer :otherID

      t.timestamps
    end
  end
end
