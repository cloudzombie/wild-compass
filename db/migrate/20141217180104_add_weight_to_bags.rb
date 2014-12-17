class AddWeightToBags < ActiveRecord::Migration
  def change
    add_column :bags, :weight, :int
  end
end
