module Fulfillable
  extend ActiveSupport::Concern

  included do
    scope :fulfilled,   -> { select('DISTINCT(orders.id), orders.*').joins(:order_lines).merge(OrderLine.joins(:jars).merge(Jar.where(fulfilled: true)))}
    scope :unfulfilled, -> { select('DISTINCT(orders.id), orders.*').joins(:order_lines).merge(OrderLine.joins(:jars).merge(Jar.where(fulfilled: false)))}
  end

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
end