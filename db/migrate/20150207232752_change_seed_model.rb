class ChangeSeedModel < ActiveRecord::Migration
  def change
    remove_column :seeds, :plant_id, :integer

    add_column :seeds, :initial_weight, :decimal, precision: 16, scale: 4
    add_column :seeds, :current_weight, :decimal, precision: 16, scale: 4

    add_column :plants, :seed_id, :integer

    add_index :plants, :seed_id
  end
end
