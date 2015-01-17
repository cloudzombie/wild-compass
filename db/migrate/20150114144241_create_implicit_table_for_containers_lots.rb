class CreateImplicitTableForContainersLots < ActiveRecord::Migration
  def change
    create_table :containers_lots do |t|
      t.belongs_to :lot, index: true
      t.belongs_to :container, index: true
    end
  end
end
