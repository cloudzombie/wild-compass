class AddHistoryIdToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :history_id, :integer
  end
end
