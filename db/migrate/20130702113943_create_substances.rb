class CreateSubstances < ActiveRecord::Migration
  def change
    create_table :substances do |t|
      t.string :generic_name
      t.string :product_name
      t.string :substanceType
      t.string :manufacturer
      t.string :supplier
      t.string :half_life
      t.integer :alert_amount, :default => 10
      t.integer :alert_days, :default => 0
      t.decimal :volume

      t.timestamps
    end
  end

  def down
    drop_table :substances
  end

end
