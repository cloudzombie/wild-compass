class ChangePlantsOridinToInteger < ActiveRecord::Migration
  def change
    remove_column :plants, :origin, :string
  end
end
