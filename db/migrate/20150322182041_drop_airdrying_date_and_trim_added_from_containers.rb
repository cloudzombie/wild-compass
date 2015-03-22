class DropAirdryingDateAndTrimAddedFromContainers < ActiveRecord::Migration
  def change
    remove_column :containers, :airdrying_stage_ended_at, :datetime
    remove_column :containers, :trim_added, :decimal
  end
end
