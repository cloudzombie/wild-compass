class RemoveStrainFromLots < ActiveRecord::Migration
  def change
    remove_column :lots, :strain, :string
  end
end
