class AddReleasedToLots < ActiveRecord::Migration
  def change
    add_column :lots, :released, :boolean, null: false, default: false
  end
end
