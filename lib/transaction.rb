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

    @source.update_column(:current_weight, @source.current_weight.to_i - @quantity.to_i)
    @source.save
    
    @target.update_column(:current_weight, @target.current_weight.to_i)
    @target.save

    @source.history.add_line(@source, @target, @quantity, :decrease)
    @target.history.add_line(@target, @source, @quantity, :increase)
    true
  end

  private

    def initialize(source)
      @source = source
    end
end