class AddNameToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :name, :string
  end
end
