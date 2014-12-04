class AddAttributesToPlants < ActiveRecord::Migration
  def change
    add_reference :plants, :cultivar, index: true
    add_reference :plants, :format, index: true
    add_reference :plants, :status, index: true
    add_reference :plants, :rfid, index: true
    add_column :plants, :origin, :string
  end
end
