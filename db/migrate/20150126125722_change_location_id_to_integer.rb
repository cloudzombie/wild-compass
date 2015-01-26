class ChangeLocationIdToInteger < ActiveRecord::Migration
  def change
    add_column :plants, :location_id, :integer
    add_column :containers, :location_id, :integer
  end
end
