class Brand < ActiveRecord::Base

  has_many :strains

  def available?
    available > 150.0
  end

  def available
    strains.bags.sum(:current_weight)
  end

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
