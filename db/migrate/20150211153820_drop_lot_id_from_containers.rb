class DropLotIdFromContainers < ActiveRecord::Migration
  def change
    remove_column :containers, :lot_id, :integer
  end
end
