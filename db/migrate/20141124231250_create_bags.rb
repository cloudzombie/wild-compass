class CreateBags < ActiveRecord::Migration
  def change
    create_table :bags do |t|

      t.timestamps
    end
  end
end
