class TrackBagIdFromStatus < ActiveRecord::Migration
  def change
    remove_column :bags, :bags_status_id, :integer
    add_column :bags_statuses, :bag_id, :integer
  end
end
