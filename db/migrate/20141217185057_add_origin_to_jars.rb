class AddOriginToJars < ActiveRecord::Migration
  def change
    add_column :jars, :origin, :int
  end
end
