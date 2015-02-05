class CreateBagsStatuses < ActiveRecord::Migration
  def change
    create_table :bags_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
