class AddInitialStockToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :initial_stock, :integer
  end
end
