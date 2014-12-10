class AddLotIdToBags < ActiveRecord::Migration
  def change
    add_column :bags, :lot_id, :integer
  end
end
