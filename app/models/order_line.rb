class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :product, polymorphic: true

  def name
    "#{ product unless product.nil? }"
  end

  def to_s
    "#{ product.class unless product.nil? } : #{ name unless name.nil? } x#{ quantity }"
  end
end
