class AddBrandIdToLots < ActiveRecord::Migration
  def change
    add_column :lots, :brand_id, :integer
  end
end
