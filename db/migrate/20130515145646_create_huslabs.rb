class CreateHuslabs < ActiveRecord::Migration
  def change
    create_table :huslabs do |t|
      t.string :description

      t.timestamps
    end
  end

  def down
    drop_table :huslabs
  end
end
