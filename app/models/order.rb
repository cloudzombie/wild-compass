class Order < ActiveRecord::Base



  ### Order lines

  has_many :order_lines
  
  accepts_nested_attributes_for :order_lines,
                                 allow_destroy: true,
                                 reject_if: :all_blank



  ### Customer

  validates :customer, presence: true

  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    else
      self.all
    end
  end

  ### Total weight

  ## 
  # Computes order's total weight
  def total_weight
    w = 0.0
    order_lines.each do |line|
      w += line.quantity * (line.jar.nil? ? 0.0 : line.jar.current_weight )
    end
    w
  end
end
