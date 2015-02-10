class AddTemporaryRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temporary_role_id, :integer
    add_column :users, :temporary_role_expires_at, :datetime
  end
end
