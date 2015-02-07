class ChangePlantsOridinToInteger < ActiveRecord::Migration
  def up
    change_column :plants, :origin, :integer
  end

  def down
    change_down :plants, :origin, :string
  end
end
