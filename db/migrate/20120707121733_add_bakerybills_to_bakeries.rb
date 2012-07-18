class AddBakerybillsToBakeries < ActiveRecord::Migration
  def change
    add_column :bakerybills, :bakery_id, :integer
  end
end
