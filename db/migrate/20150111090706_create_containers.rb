class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :lot_id
      t.decimal :current_weight
      t.decimal :initial_weight

      t.timestamps
    end
  end
end
