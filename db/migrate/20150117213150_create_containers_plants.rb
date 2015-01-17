class CreateContainersPlants < ActiveRecord::Migration
  def change
    create_table :containers_plants do |t|
      t.belongs_to :plant, index: true
      t.belongs_to :container, index: true
    end
  end
end
