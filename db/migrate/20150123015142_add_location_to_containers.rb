class AddLocationToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :location, :string
  end
end
