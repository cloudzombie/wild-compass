class DropTableCultivars < ActiveRecord::Migration
  def change
    drop_table :cultivars
  end
end
