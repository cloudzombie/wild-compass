class AddRecalledAndQuarantinedToLots < ActiveRecord::Migration
  def change
    add_column :lots, :recalled,    :boolean, null: false, default: false
    add_column :lots, :quarantined, :boolean, null: false, default: false
  end
end
