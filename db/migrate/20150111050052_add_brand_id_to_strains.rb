class AddBrandIdToStrains < ActiveRecord::Migration
  def change
    add_column :strains, :brand_id, :integer
  end
end
