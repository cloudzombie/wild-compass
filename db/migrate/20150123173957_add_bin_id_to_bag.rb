class AddBinIdToBag < ActiveRecord::Migration
  def change
    add_column :bags, :bin_id, :integer
  end
end
