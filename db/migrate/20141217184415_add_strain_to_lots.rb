class AddStrainToLots < ActiveRecord::Migration
  def change
    add_column :lots, :strain, :string
  end
end
