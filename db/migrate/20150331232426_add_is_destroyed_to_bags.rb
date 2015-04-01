class AddIsDestroyedToBags < ActiveRecord::Migration
  def change
    add_column :bags, :is_destroyed, :boolean, null: false, default: false
  end
end
