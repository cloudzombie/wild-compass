class AddNameToBags < ActiveRecord::Migration
  def change
    add_column :bags, :name, :string
  end
end
