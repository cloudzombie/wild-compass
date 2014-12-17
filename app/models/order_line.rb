class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :product, polymorphic: true
end
