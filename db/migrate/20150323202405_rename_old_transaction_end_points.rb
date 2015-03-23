class RenameOldTransactionEndPoints < ActiveRecord::Migration
  def change
    rename_table :harvests, :transactions_harvests
    rename_table :wastes,   :transactions_wastes
  end
end
