class CreateEluates < ActiveRecord::Migration
  def change
    create_table :eluates do |t|
      t.string :name

      t.timestamps
    end

  end
end
