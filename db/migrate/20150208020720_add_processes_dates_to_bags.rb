class AddProcessesDatesToBags < ActiveRecord::Migration
  def change
    add_column :bags, :airdrying_stage_ended_at, :datetime
    add_column :bags, :processing_completed_at, :datetime
  end
end
