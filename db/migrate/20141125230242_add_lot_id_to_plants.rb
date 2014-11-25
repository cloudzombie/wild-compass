class AddLotIdToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :lot_id, :integer
  end
end
