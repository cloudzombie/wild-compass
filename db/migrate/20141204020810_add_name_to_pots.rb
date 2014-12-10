class AddNameToPots < ActiveRecord::Migration
  def change
    add_column :pots, :name, :string
  end
end
