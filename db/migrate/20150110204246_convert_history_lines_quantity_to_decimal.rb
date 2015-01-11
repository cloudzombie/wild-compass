class ConvertHistoryLinesQuantityToDecimal < ActiveRecord::Migration
  def change
    change_column :history_lines, :quantity, :decimal, precision: 16, scale: 4
  end
end
