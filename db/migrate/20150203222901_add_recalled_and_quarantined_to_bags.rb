class AddRecalledAndQuarantinedToBags < ActiveRecord::Migration
  def change
    add_column :bags, :recalled,    :boolean, null: false, default: false
    add_column :bags, :quarantined, :boolean, null: false, default: false
  end
end
