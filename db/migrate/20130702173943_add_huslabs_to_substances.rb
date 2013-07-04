class AddHuslabsToSubstances < ActiveRecord::Migration

  def change
    add_column :substances, :huslab_id, :integer
  end
end

