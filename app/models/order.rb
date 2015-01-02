class Order < ActiveRecord::Base



  ### Order lines

  has_many :order_lines
  
  accepts_nested_attributes_for :order_lines

  validates :order_lines, presence: true



  ### Customer

  validates :customer, presence: true



  ### Total weight

  ## 
  # Computes order's total weight
  def total_weight
    w = 0
    order_lines.each do |line|
      w += line.quantity.to_i * (line.product.nil? ? 0 : line.product.current_weight.to_i)
    end
    w
  end
end
