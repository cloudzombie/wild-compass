class AddTypeToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :type, :string, null: false, default: 'Container'
  end
end
