class AddLocationToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :location, :string
  end
end
