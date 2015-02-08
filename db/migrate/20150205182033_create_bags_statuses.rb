class CreateBagsStatuses < ActiveRecord::Migration
  def change
    create_table :bags_statuses do |t|
      t.string :name, null: false, default: ''

      t.timestamps
    end

    add_index :bags_statuses, :name, unique: true
  end
end
