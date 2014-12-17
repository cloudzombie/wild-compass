class AddWeightToJars < ActiveRecord::Migration
  def change
    add_column :jars, :weight, :int
  end
end
