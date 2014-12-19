class AddManagerAndAdminToUserGroupRoles < ActiveRecord::Migration
  def change
    add_column :user_group_roles, :manager, :boolean, default: false
    add_column :user_group_roles, :admin, :boolean, default: false
  end
end
