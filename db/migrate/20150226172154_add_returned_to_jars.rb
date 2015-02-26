class AddReturnedToJars < ActiveRecord::Migration
  def change
    add_column :jars, :returned, :boolean, null: false, default: false
  end
end
