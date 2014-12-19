class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :hystoriable, index: true, polymorphic: true
      
      t.timestamps
    end
  end
end
