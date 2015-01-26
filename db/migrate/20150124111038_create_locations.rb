class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.integer :plant_ids
      t.integer :bin_ids
      t.integer :container_ids

      t.timestamps
    end
  end
end
