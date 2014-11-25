class AddBagIdToPot < ActiveRecord::Migration
  def change
    add_column :pots, :bag_id, :integer
  end
end
