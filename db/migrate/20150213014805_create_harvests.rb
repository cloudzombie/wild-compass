class CreateHarvests < ActiveRecord::Migration
  def change
    create_table :harvests do |t|

      t.timestamps
    end
  end
end
