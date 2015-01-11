class AddContainerIdToBags < ActiveRecord::Migration
  def change
    add_column :bags, :container_id, :integer
  end
end
