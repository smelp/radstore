class CreateBakeryorders < ActiveRecord::Migration
  def change
    create_table :bakeryorders do |t|
      t.string :delivery_type
      t.string :state

      t.timestamps
    end
  end
end
