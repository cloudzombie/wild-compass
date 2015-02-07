class AddContainerIdToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :container_id, :integer
  end
end
