class CreateSubstances < ActiveRecord::Migration
  def change
    create_table :substances do |t|
      t.string :genericName
      t.string :eluateName
      t.string :substanceType
      t.string :manufacturer
      t.string :supplier

      t.timestamps
    end
  end

  def down
    drop_table :substances
  end

end
