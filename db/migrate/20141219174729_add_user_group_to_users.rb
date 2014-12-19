class AddUserGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer
    add_column :users, :user_role_id, :integer
  end
end
