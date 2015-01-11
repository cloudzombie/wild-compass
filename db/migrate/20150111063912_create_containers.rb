class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.decimal :initial_weight
      t.decimal :current_weight
      t.integer :lot_id
      t.string :category

      t.timestamps
    end
  end
end
