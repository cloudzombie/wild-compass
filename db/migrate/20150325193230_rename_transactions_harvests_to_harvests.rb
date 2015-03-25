class RenameTransactionsHarvestsToHarvests < ActiveRecord::Migration
  def change
    rename_table :transactions_harvests, :harvests
  end
end
