class AddUserGroupRoleIdToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :user_group_role_id, :integer
  end
end
