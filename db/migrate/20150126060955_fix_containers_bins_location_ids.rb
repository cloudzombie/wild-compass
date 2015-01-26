class FixContainersBinsLocationIds < ActiveRecord::Migration
  def change
  	remove_column :containers, :location, :string
  end
end
