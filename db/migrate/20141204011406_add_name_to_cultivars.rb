class AddNameToCultivars < ActiveRecord::Migration
  def change
    add_column :cultivars, :name, :string
  end
end
