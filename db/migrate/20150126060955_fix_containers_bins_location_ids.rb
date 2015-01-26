class FixContainersBinsLocationIds < ActiveRecord::Migration
  def change
  	rename_column :containers, :location, :location_id
  end
end
