class AddDescriptionToStrains < ActiveRecord::Migration
  def change
    add_column :strains, :description, :string
  end
end
