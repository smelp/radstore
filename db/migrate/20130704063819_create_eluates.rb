class CreateEluates < ActiveRecord::Migration
  def change
    create_table :eluates do |t|
      t.string :name
      t.references :storagelocation
      t.references :radiomedicine

      t.timestamps
    end

  end
end
