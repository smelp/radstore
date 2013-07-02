class CreateSubstances < ActiveRecord::Migration
  def change
    create_table :substances do |t|
      t.string :genericName
      t.string :eluateName
      t.integer :type
      t.string :manufacturer
      t.string :supplier

      t.timestamps
    end
  end

  def down
    drop_table :materials
  end

end
