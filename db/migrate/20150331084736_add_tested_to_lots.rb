class AddTestedToLots < ActiveRecord::Migration
  def change
    add_column :lots, :tested, :boolean, null: false, default: false
  end
end
