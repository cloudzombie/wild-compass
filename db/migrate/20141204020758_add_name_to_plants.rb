class AddNameToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :name, :string
  end
end
