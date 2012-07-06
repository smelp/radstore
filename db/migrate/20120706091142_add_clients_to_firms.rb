class AddClientsToFirms < ActiveRecord::Migration
  def change
    add_column :clients, :firm_id, :integer
  end
end
