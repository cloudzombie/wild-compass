class AddEventToHistoryLines < ActiveRecord::Migration
  def change
    add_column :history_lines, :event, :string
  end
end
