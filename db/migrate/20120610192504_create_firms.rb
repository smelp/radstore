class CreateFirms < ActiveRecord::Migration
  def up
    create_table :firms, :force => true do |t|
      t.string :name
      t.string :corporate_id
      t.string :location
      t.references :resource, :polymorphic => true
	  
      t.timestamps
    end
  end
  
  def down 
    drop_table :firms
  end
end
