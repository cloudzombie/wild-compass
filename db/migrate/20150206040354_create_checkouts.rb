class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.references :target, polymorphic: true, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :checkouts, [:target_id, :target_type], unique: true
    add_index :checkouts, :user_id
  end
end
