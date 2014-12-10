class AddNameToRfids < ActiveRecord::Migration
  def change
    add_column :rfids, :name, :string
  end
end
