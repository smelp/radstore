class AddRecipesToFirms < ActiveRecord::Migration
  def change
    add_column :recipes, :firm_id, :integer
  end
end
