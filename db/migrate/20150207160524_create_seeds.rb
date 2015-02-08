class CreateSeeds < ActiveRecord::Migration
  def change
    create_table :seeds do |t|
      t.string :name

      t.integer :plant_id, null: false

      t.timestamps
    end

    add_index :seeds, :plant_id, unique: true
  end
end
