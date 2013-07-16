class CreateRadiomedicines < ActiveRecord::Migration
  def change
    create_table :radiomedicines do |t|
      t.string :name
      t.integer :storagelocation_id
      t.references :eluate
      t.decimal :radioactivity
      t.decimal :volume

      t.timestamps
    end
    add_index :radiomedicines, :name
  end
end
