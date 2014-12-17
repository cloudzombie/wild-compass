class AddInitialWeightToLots < ActiveRecord::Migration
  def change
    add_column :lots, :initial_weight, :int
  end
end
