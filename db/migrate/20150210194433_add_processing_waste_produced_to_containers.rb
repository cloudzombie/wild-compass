class AddProcessingWasteProducedToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :processing_waste_produced, :decimal, precision: 16, scale: 4
  end
end
