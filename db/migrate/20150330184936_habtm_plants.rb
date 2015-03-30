class HabtmPlants < ActiveRecord::Migration
  def change
    create_table :lots_plants, id: false do |t|
      t.belongs_to :plants, index: true
      t.belongs_to :lots, index: true
    end
  end
end
