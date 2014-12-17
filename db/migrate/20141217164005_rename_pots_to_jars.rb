class RenamePotsToJars < ActiveRecord::Migration
  def change
    rename_table :pots, :jars
  end
end
