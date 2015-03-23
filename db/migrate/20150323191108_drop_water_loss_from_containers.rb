class DropWaterLossFromContainers < ActiveRecord::Migration
  def change
    remove_column :containers, :water_loss, :decimal
  end
end
