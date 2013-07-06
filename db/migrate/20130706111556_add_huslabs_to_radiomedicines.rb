class AddHuslabsToRadiomedicines < ActiveRecord::Migration
  def change
    add_column :radiomedicines, :huslab_id, :integer

  end
end
