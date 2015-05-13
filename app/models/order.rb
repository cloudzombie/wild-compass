class Order < ActiveRecord::Base

  include Searchable
  include Sortable
  include Fulfillable



  ### CES

  validates :ces_order_id, uniqueness: true



  ### Customer

  validates :customer, presence: true



  ### Order lines

  has_many :jars, -> { uniq }, through: :order_lines

  has_many :order_lines
  
  accepts_nested_attributes_for :order_lines, allow_destroy: true, reject_if: :all_blank
  
  

  ### Total weight

  ## 
  # Computes order's total weight
  def total_weight
    order_lines.sum(:quantity)
  end

  def to_s
    "ORDER-#{ces_order_id}".upcase
  end

  alias_method :name, :to_s

end
