class AddArchivedToBags < ActiveRecord::Migration
  def change
    add_column :bags, :archived, :boolean, null: false, default: false
  end
end
