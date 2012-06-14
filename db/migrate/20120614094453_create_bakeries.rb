class CreateBakeries < ActiveRecord::Migration
  def change
    create_table :bakeries do |t|
      t.string :description
      
      t.timestamps
    end
  end
  
  def down
    drop_table :bakeries
  end
end
