class AddSentToLabToBags < ActiveRecord::Migration
  def change
    add_column :bags, :sent_to_lab, :boolean, null: false, default: false
  end
end
