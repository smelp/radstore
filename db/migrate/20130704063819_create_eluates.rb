class CreateEluates < ActiveRecord::Migration
  def change
    create_table :eluates do |t|
      t.string :name
      t.references :storagelocation
      t.decimal :radioactivity
      t.decimal :volume

      t.timestamps
    end

  end
end
