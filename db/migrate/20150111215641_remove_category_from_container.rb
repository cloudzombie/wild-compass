class RemoveCategoryFromContainer < ActiveRecord::Migration
  def change
    remove_column :containers, :category, :string
  end
end
