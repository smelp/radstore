class AddHuslabsToEluates < ActiveRecord::Migration
  def change
    add_column :eluates, :huslab_id, :integer

  end
end
