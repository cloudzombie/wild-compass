class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :brand

  validates :brand, presence: true

  belongs_to :jar

  def name
    "#{ brand unless brand.nil? }"
  end

  def to_s
    "#{ name unless name.nil? } (#{ jar unless jar.nil?}) --- #{ quantity }"
  end
end
