class Transaction
  def self.from(source)
    Transaction.new(source)
  end

  def to(target)
    @target = target
    self
  end

  def take(quantity)
    @quantity = quantity
    self
  end

  def commit
    raise "source is nil" if @source.nil?
    raise "target is nil" if @target.nil?
    raise "quantity is nil or zero" if @quantity.nil? || @quantity.to_d == 0.0

    @source.decrease_current_weight(@quantity)
    @target.increase_current_weight(@quantity)
  
    @source.history.add_line(@source, @target, @quantity, :decrease_current_weight, current_user)
    @target.history.add_line(@target, @source, @quantity, :increase_current_weight, current_user)

    true
  end

  private

    def initialize(source)
      @source = source
    end

end