class Order < ActiveRecord::Base



  ### Order lines

  has_many :order_lines



  ### Customer

  validates :customer, presence: true



  ### Total weight

  def total_weight #Set order total weight.
    w = 0
    order_lines.each do |line|
      w += line.quantity.to_i * (line.product.nil? ? 0 : line.product.current_weight.to_i)
    end
    w
  end
end
