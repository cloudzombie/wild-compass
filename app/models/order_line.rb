class OrderLine < ActiveRecord::Base

  MINIMUM_ORDER_QUANTITY =   0.0
  MAXIMUM_ORDER_QUANTITY = 150.0

  belongs_to :order


  
  belongs_to :brand

  validates :brand, presence: true


  
  has_many :jars

  after_create :create_jars



  validates :quantity, presence: true, allow_blank: false

  validates :quantity, numericality: {
    greater_than_or_equal_to: MINIMUM_ORDER_QUANTITY,
    less_than_or_equal_to:    MAXIMUM_ORDER_QUANTITY
  }



  def name
    "#{ brand unless brand.nil? }"
  end

  def to_s
    "#{ name unless name.nil? } --- #{ quantity }"
  end

  private

    def create_jars
      return if self.quantity == 0.0 || self.quantity.nil?
      for i in 0...(self.quantity.to_f/10.0).ceil
        self.jars << Jar.create
      end
    end

end
