class AddHistoryIdToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :history_id, :integer
  end
end
