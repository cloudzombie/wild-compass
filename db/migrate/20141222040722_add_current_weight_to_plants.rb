class AddCurrentWeightToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :current_weight, :int
  end
end
