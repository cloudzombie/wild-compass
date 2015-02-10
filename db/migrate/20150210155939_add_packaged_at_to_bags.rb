class AddPackagedAtToBags < ActiveRecord::Migration
  def change
    add_column :bags, :packaged_at, :datetime
  end
end
