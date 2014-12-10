class CreateCultivars < ActiveRecord::Migration
  def change
    create_table :cultivars do |t|

      t.timestamps
    end
  end
end
