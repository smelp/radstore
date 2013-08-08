class CreateEluates < ActiveRecord::Migration
  def change
    create_table :eluates do |t|
      t.string :name
      t.references :storagelocation
      t.string :radioactivity
      t.string :volume

      t.timestamps
    end

  end
end
