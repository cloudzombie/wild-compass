class AddCbnCompositionToLots < ActiveRecord::Migration
  def change
    add_column :lots, :cbn_composition, :decimal, precision: 5, scale: 2
  end
end
