class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.references :product, index: true, polymorphic: true
      t.integer :quantity
      t.timestamps
    end
  end
end
