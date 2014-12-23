class ConvertWeightsToDecimals < ActiveRecord::Migration
  def change
    change_column :bags, :current_weight, :decimal, precision: 10, scale: 4
    change_column :bags, :initial_weight, :decimal, precision: 10, scale: 4

    change_column :jars, :current_weight, :decimal, precision: 10, scale: 4
    change_column :jars, :initial_weight, :decimal, precision: 10, scale: 4

    change_column :lots, :current_weight, :decimal, precision: 10, scale: 4
    change_column :lots, :initial_weight, :decimal, precision: 10, scale: 4
  end
end
