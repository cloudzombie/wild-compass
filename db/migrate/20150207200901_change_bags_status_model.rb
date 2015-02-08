class ChangeBagsStatusModel < ActiveRecord::Migration
  def change
    remove_column :bags, :recalled,       :boolean
    remove_column :bags, :quarantined,    :boolean
    add_column    :bags, :bags_status_id, :integer
  end
end
