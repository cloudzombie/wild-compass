class ChangePlantsOridinToInteger < ActiveRecord::Migration
  def change
    change_column :plants, :origin, :integer
  end
end
