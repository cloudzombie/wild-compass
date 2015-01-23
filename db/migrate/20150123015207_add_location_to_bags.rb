class AddLocationToBags < ActiveRecord::Migration
  def change
    add_column :bags, :location, :string
  end
end
