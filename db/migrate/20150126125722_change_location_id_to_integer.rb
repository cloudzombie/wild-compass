class ChangeLocationIdToInteger < ActiveRecord::Migration
  def change
    change_column :plants, :location_id, :integer
    change_column :containers, :location_id, :integer
  end
end
