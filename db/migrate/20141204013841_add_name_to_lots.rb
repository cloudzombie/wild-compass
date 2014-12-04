class AddNameToLots < ActiveRecord::Migration
  def change
    add_column :lots, :name, :string
  end
end
