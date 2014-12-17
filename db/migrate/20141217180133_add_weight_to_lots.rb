class AddWeightToLots < ActiveRecord::Migration
  def change
    add_column :lots, :weight, :int
  end
end
