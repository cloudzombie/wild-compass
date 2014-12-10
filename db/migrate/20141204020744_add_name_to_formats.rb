class AddNameToFormats < ActiveRecord::Migration
  def change
    add_column :formats, :name, :string
  end
end
