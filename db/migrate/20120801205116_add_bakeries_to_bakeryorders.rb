class AddBakeriesToBakeryorders < ActiveRecord::Migration
  def change
    add_column :bakeryorders, :bakery_id, :integer
  end
end
