class AddNameToBin < ActiveRecord::Migration
  def change
    add_column :bins, :name, :string
  end
end
