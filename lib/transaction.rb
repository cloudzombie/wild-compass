class Transaction
  def self.from(source)
    Transaction.new(source)
  end

  def to(target)
    @target = target
    self
  end

  def take(quantity)
    @quantity = quantity * 1000
    self
  end

  def commit(opts = nil)
    raise "source is nil" if @source.nil?
    raise "target is nil" if @target.nil?
    raise "quantity is nil or zero" if @quantity.to_i == 0

    if opts[:initial]
      @source.decrease_current_weight(@quantity.to_i)

      @source.history.add_line(@source, @target, @quantity, :decrease_current_weight)
      @target.history.add_line(@target, @source, @quantity, :increase_current_weight)
    else
      @source.decrease_current_weight(@quantity.to_i)
      @target.increase_current_weight(@quantity.to_i)
    
      @source.history.add_line(@source, @target, @quantity, :decrease_current_weight)
      @target.history.add_line(@target, @source, @quantity, :increase_current_weight)
    end

    true
  end

  private

    def initialize(source)
      @source = source
    end

end