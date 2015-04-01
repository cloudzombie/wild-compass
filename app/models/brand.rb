class Brand < ActiveRecord::Base

  has_many :strains

  has_many :lots

  def available?
    available >= 150.0
  end

  def available
    lots.where(released: true).sum(:current_weight)
  end

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
