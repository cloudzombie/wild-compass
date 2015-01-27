class Order < ActiveRecord::Base

  include Searchable
  include Encodable



  ### Order lines

  has_many :order_lines
  
  accepts_nested_attributes_for :order_lines,
                                 allow_destroy: true,
                                 reject_if: :all_blank



  ### Customer

  validates :customer, presence: true

  

  ### Total weight

  ## 
  # Computes order's total weight
  def total_weight
    w = 0.0
    order_lines.each do |line|
      w += line.quantity
    end
    w
  end
end
