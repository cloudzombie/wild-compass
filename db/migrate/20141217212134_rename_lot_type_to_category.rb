class RenameLotTypeToCategory < ActiveRecord::Migration
  def change
    rename_column :lots, :type, :category
  end
end
