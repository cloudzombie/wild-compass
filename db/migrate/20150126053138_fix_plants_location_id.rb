class FixPlantsLocationId < ActiveRecord::Migration
  def change
    remove_column :plants, :location, :string
  end
end
