class CreateRfids < ActiveRecord::Migration
  def change
    create_table :rfids do |t|

      t.timestamps
    end
  end
end
