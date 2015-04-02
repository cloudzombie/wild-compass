class Order < ActiveRecord::Base

  include Searchable

  scope :fulfilled,   -> {  select('DISTINCT(orders.id), orders.*')
                           .joins(:order_lines)
                           .merge( OrderLine.joins(:jars)
                                            .merge( Jar.where(fulfilled: true)
                         ))}

  scope :unfulfilled, -> {  select('DISTINCT(orders.id), orders.*')
                           .joins(:order_lines)
                           .merge( OrderLine.joins(:jars)
                                            .merge( Jar.where(fulfilled: false)
                         ))}

  validates :ces_order_id, uniqueness: true

  def first_unfulfilled
    order_lines.each do |line|
      line.jars.each do |jar|
        return jar if jar.unfulfilled?
      end
    end
    return
  end

  def unfulfilled?
    !fulfilled?
  end

  def fulfilled?
    first_unfulfilled == nil
  end

  ### Order lines

  has_many :jars, -> { uniq }, through: :order_lines
  
  has_many :bags, -> { uniq }, through: :jars

  has_many :bins, -> { uniq }, through: :bags

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
    order_lines.sum(:quantity)
  end

end
