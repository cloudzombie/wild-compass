class AddNameToUserGroupRoles < ActiveRecord::Migration
  def change
    add_column :user_group_roles, :name, :string
  end
end
