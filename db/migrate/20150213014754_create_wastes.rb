class CreateWastes < ActiveRecord::Migration
  def change
    create_table :wastes do |t|

      t.timestamps
    end
  end
end
