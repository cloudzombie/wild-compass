class AddFulfilledToJars < ActiveRecord::Migration
  def change
    add_column :jars, :fulfilled, :boolean, null: false, default: false
  end
end
