class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :event, null: false
      t.references :source, polymorphic: true, index: true
      t.references :target, polymorphic: true, index: true
      t.decimal :weight, precision: 16, scale: 4, null: false

      t.timestamps
    end
  end
end
