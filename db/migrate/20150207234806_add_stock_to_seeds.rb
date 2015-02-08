class AddStockToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :stock, :integer
  end
end
