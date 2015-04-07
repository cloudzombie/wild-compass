class OrderLine < ActiveRecord::Base

  MINIMUM_ORDER_QUANTITY =   0.0
  MAXIMUM_ORDER_QUANTITY = 150.0



  ### Order

  belongs_to :order


  
  ### Brand

  belongs_to :brand

  validates :brand, presence: true



  ### Jar
  
  has_many :jars

  accepts_nested_attributes_for :jars

  after_create :create_jars_and_set_ordered_amount



  ### Quantity

  validates :quantity, presence: true, allow_blank: false

  validates :quantity, numericality: {
    greater_than_or_equal_to: MINIMUM_ORDER_QUANTITY,
    less_than_or_equal_to:    MAXIMUM_ORDER_QUANTITY
  }



  def name
    "#{brand}"
  rescue NoMethodError => e
    Raven.capture_exception(e)
    ''
  end

  def to_s
    "#{name} --- #{quantity}"
  rescue NoMethodError => e
    Raven.capture_exception(e)
    ''
  end

  private

    def create_jars_and_set_ordered_amount
      return true if quantity == 0.0
      
      for i in 0...(quantity.to_f/10.0).ceil
        jars << Jar.create!
      end

      jars.each do |jar|
        jar.update_attributes!(ordered_amount: jar.amount_to_fill)
        
        Transaction.create!(
          source: Wild::Compass::Product.first_available_bag_by_brand(brand),
          target: jar,
          weight: 0.0,
          event: Time.now
        )
      end
      
      true

    rescue ActiveRecord::RecordInvalid => e
      Raven.capture_exception(e)
      false
    end

end
