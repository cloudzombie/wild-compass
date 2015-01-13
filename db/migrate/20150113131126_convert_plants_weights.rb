class ConvertPlantsWeights < ActiveRecord::Migration
  def change
    change_column :plants, :current_weight, :decimal, precision: 16, scale: 4
    change_column :plants, :initial_weight, :decimal, precision: 16, scale: 4
  end
end
