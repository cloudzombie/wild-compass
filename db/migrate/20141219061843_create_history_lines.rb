class CreateHistoryLines < ActiveRecord::Migration
  def change
    create_table :history_lines do |t|
      t.references :history, index: true

      t.references :source, polymorphic: true
      t.references :target, polymorphic: true
      
      t.integer :quantity

      t.timestamps
    end
  end
end
