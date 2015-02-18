class AddVarianceAndDeltasToBags < ActiveRecord::Migration
  def change
    add_column :bags, :variance, :decimal, precision: 16, scale: 4, default: 0.0
    add_column :bags, :delta, :decimal, precision: 16, scale: 4, default: 0.0
    add_column :bags, :delta_old, :decimal, precision: 16, scale: 4, default: 0.0
  end
end
