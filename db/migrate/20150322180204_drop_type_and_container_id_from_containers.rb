class DropTypeAndContainerIdFromContainers < ActiveRecord::Migration
  def change
    remove_column :containers, :type, :string
    remove_column :containers, :container_id, :integer
  end
end
