class RenameWeightToCurrentWeight < ActiveRecord::Migration
  def change
    rename_column :bags, :weight, :current_weight
    rename_column :jars, :weight, :current_weight
    rename_column :lots, :weight, :current_weight
    add_column :jars, :initial_weight, :integer
  end
end
