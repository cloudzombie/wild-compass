class AddOriginToLots < ActiveRecord::Migration
  def change
    add_column :lots, :origin, :int
  end
end
