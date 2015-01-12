class ConvertOrderLinesQuantityToDecimal < ActiveRecord::Migration
  def change
    change_column :order_lines, :quantity, :decimal, precision: 16, scale: 4
  end
end
