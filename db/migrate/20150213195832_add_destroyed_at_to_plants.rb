class AddDestroyedAtToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :destroyed_at, :datetime
  end
end
