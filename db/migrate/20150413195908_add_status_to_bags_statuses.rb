class AddStatusToBagsStatuses < ActiveRecord::Migration
  def change
    add_column :bags_statuses, :quarantined, :boolean, null: false, default: false
    add_column :bags_statuses, :cleared,     :boolean, null: false, default: false
    add_column :bags_statuses, :recalled,    :boolean, null: false, default: false
    add_column :bags_statuses, :released,    :boolean, null: false, default: false
    add_column :bags_statuses, :tested,      :boolean, null: false, default: false
  end
end
