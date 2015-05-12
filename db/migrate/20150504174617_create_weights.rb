class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.references :weightable, polymorphic: true, index: true

      t.datetime :weighted_at, null: false
      t.decimal :value, null: false, precision: 16, scale: 4

      t.timestamps
    end

    add_index :weights, [ :weighted_at, :value ], unique: true
  end
end
