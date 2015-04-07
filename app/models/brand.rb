class Brand < ActiveRecord::Base

  has_many :strains

  has_many :lots

  def to_s
    "#{ name.titleize unless name.nil? }"
  end
end
