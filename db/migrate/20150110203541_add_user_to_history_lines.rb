class AddUserToHistoryLines < ActiveRecord::Migration
  def change
    add_column :history_lines, :user_id, :integer
  end
end
