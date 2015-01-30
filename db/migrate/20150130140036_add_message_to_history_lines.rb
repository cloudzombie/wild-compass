class AddMessageToHistoryLines < ActiveRecord::Migration
  def change
    add_column :history_lines, :message, :text, null: false, default: ''
  end
end
