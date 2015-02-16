class AddWaterLossToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :water_loss, :decimal, precision: 16, scale: 4
  end
end
