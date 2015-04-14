class AddDestroyedAndSentToLabToStatuses < ActiveRecord::Migration
  def change
    add_column :bags_statuses, :is_destroyed, :boolean, null: false, default: false
    add_column :bags_statuses, :sent_to_lab,  :boolean, null: false, default: false

    add_column :jars_statuses, :is_destroyed, :boolean, null: false, default: false
  end
end
