class AddInitialWeightToBags < ActiveRecord::Migration
  def change
    add_column :bags, :initial_weight, :int
  end
end
