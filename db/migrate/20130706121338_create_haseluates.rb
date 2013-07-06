class CreateHaseluates < ActiveRecord::Migration
  def change
    create_table :haseluates do |t|
      t.references :radiomedicine
      t.references :eluate

      t.timestamps
    end
    add_index :haseluates, :eluate_id
  end
end
