class CreateBakerybills < ActiveRecord::Migration
  def change
    create_table :bakerybills do |t|

      t.timestamps
    end
  end
end
