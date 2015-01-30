class AddCompositionsToLots < ActiveRecord::Migration
  def change
    add_column :lots, :thc_composition, :decimal, precision: 5, scale: 2
    add_column :lots, :cbd_composition, :decimal, precision: 5, scale: 2
  end
end
