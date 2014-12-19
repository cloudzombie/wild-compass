class AddManagerAndAdminToRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :manager, :boolean, default: false
    add_column :user_roles, :admin, :boolean, default: false
  end
end
