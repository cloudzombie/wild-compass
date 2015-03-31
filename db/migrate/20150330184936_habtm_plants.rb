class HabtmPlants < ActiveRecord::Migration
  def change
    create_table :lots_plants, id: false do |t|
      t.belongs_to :plant, index: true
      t.belongs_to :lot, index: true
    end
  end
end
