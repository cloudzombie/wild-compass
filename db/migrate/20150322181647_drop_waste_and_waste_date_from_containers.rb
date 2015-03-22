class DropWasteAndWasteDateFromContainers < ActiveRecord::Migration
  def change
    remove_column :containers, :processing_waste_produced, :decimal
    remove_column :containers, :processing_completed_at, :datetime
  end
end
