class AddInitialWeightToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :initial_weight, :int
  end
end
