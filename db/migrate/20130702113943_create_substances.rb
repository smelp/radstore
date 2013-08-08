class CreateSubstances < ActiveRecord::Migration
  def change
    create_table :substances do |t|
      t.string :genericName
      t.string :eluateName
      t.string :substanceType
      t.string :manufacturer
      t.string :supplier
      t.string :half_life
      t.integer :alert_amount
      t.integer :alert_days

      t.timestamps
    end
  end

  def down
    drop_table :substances
  end

end
