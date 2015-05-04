class DropNameAndUniqueIndexFromBagsStatuses < ActiveRecord::Migration
  def change
    remove_column :bags_statuses, :name, :string
  end
end
