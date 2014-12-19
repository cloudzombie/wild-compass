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
    @source.update_column(:current_weight, @source.current_weight - @quantity)
    @target.update_column(:current_weight, @target.current_weight + @quantity)
    @source.history.add_line(@source, @target, @quantity)
    @target.history.add_line(@source, @target, @quantity)
    true
  end

  private

    def initialize(source)
      @source = source
    end
end