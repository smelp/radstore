class CreateRadiomedicines < ActiveRecord::Migration
  def change
    create_table :radiomedicines do |t|
      t.string :name

      t.timestamps
    end
    add_index :radiomedicines, :name
  end
end
