class AddProcessesDatesToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :airdrying_stage_ended_at, :datetime
    add_column :containers, :processing_completed_at,  :datetime
  end
end
