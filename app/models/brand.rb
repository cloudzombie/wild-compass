class Brand < ActiveRecord::Base

  has_many :strains

  has_many :lots

  def available?
    available >= 150.0
  end

  def available
    lots.available.sum(:current_weight)
  end

  def first_available
    lots.first_available
  end

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
