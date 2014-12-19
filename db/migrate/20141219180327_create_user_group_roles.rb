class CreateUserGroupRoles < ActiveRecord::Migration
  def change
    create_table :user_group_roles do |t|
      t.timestamps
    end
  end
end
