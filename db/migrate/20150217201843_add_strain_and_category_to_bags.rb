class AddStrainAndCategoryToBags < ActiveRecord::Migration
  def change
    add_column :bags, :strain, :string
    add_column :bags, :category, :string
  end
end
