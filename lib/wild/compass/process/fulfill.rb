class Wild::Compass::Process::Fulfill
  
  def initialize(order_id)
    @order = Order.find(order_id)
  end

end