class CreateEluates < ActiveRecord::Migration
  def change
    create_table :eluates do |t|
      t.string :name
      t.integer :storagelocation_id

      t.timestamps
    end

  end
end
