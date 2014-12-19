class RenameCultivarIdToStrainId < ActiveRecord::Migration
  def change
    rename_column :plants, :cultivar_id, :strain_id
  end
end
