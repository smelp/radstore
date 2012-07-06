class CreateFirmsUsersTable < ActiveRecord::Migration
  def up
  create_table :firms_users, :id => false do |t|
        t.references :firm
        t.references :user
    end
    add_index :firms_users, [:firm_id, :user_id], :unique => true
    add_index :firms_users, :user_id, :unique => false
  end

  def self.down
    drop_table :firms_users
  end
end
