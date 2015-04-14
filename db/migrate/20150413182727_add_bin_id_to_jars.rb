class AddBinIdToJars < ActiveRecord::Migration
  def change
    add_column :jars, :bin_id, :integer
  end
end
