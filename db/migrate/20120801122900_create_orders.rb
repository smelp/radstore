class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :client
      t.references :bill
      t.references :suborder, :polymorphic => true

      t.timestamps
    end
  end
end
