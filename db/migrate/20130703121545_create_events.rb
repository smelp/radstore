class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :target_id
      t.integer :event_type
      t.datetime :timestamp
      t.string :signature, :limit => 10

      t.timestamps
    end
  end
end
