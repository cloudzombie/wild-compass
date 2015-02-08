class AddTypeToPlants < ActiveRecord::Migration
  def change
    add_column :plants, :type, :string, null: false, default: 'Plant'
  end
end
