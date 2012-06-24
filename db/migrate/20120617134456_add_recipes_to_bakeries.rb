class AddRecipesToBakeries < ActiveRecord::Migration
  def change
    add_column :recipes, :bakery_id, :integer
  end
end
