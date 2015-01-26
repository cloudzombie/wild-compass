class AddLocationIdToBin < ActiveRecord::Migration
  def change
    add_column :bins, :location_id, :integer
  end
end
