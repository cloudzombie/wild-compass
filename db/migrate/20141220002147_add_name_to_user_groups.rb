class AddNameToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :name, :string
  end
end
