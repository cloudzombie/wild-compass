class RenamePlantTypeToOldType < ActiveRecord::Migration
  def change
    rename_column :plants, :type, :old_type
  end
end
