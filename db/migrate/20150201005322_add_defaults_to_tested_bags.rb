class AddDefaultsToTestedBags < ActiveRecord::Migration
  def change
    change_column :bags, :tested, :boolean, default: false
  end
end
