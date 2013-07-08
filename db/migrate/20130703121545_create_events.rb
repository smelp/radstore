class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :target_id
      t.string :event_type
      t.datetime :user_timestamp
      t.string :signature, :limit => 10
      t.string :info

      t.timestamps
    end
  end
end
