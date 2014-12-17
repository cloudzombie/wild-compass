class AddOriginToBags < ActiveRecord::Migration
  def change
    add_column :bags, :origin, :int
  end
end
