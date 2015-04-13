class CreateJarsStatuses < ActiveRecord::Migration
  def change
    create_table :jars_statuses do |t|
      t.belongs_to :jar, null: false

      t.boolean :sent_to_lab, null: false, default: false
      t.boolean :returned, null: false, default: false

      t.timestamps
    end
  end
end
