class AddTestedToBags < ActiveRecord::Migration
  def change
    add_column :bags, :tested, :boolean
  end
end
