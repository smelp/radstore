class AddMaterialsToBakeries < ActiveRecord::Migration
  def change
    add_column :materials, :bakery_id, :integer
  end
end
