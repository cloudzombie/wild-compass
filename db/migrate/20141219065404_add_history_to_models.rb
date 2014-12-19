class AddHistoryToModels < ActiveRecord::Migration
  def change
    add_column :plants, :history_id, :integer
    add_column :jars, :history_id, :integer
    add_column :lots, :history_id, :integer
    add_column :bags, :history_id, :integer
  end
end
