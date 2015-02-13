class AddTrimAddedToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :trim_added, :decimal, precision: 16, scale: 4
  end
end
