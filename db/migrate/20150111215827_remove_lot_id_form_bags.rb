class RemoveLotIdFormBags < ActiveRecord::Migration
  def change
    remove_column :bags, :lot_id, :integer
  end
end
