class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :delivery_type
      t.date :due_date
      t.float :total_amount
      t.references :subbill, :polymorphic => true

      t.timestamps
    end
  end
end
