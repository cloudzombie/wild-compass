class Transaction
  def self.from(source)
    Transaction.new(source)
  end

  def to(target)
    @target = target
    
    self
  end

  def take(quantity)
    @source.quantity = quantity unless @source.nil?
    @target.quantity = quantity unless @target.nil?
    
    @quantity = quantity
    
    self
  end

  def by(user)
    @user = user

    self
  end

  def commit
    @source.decrease_current_weight unless @source.nil?
    @target.increase_current_weight unless @target.nil?
  
    @source.history.add_line(@source, @target, @quantity, :decrease_current_weight, @user) unless @source.nil?
    @target.history.add_line(@target, @source, @quantity, :increase_current_weight, @user) unless @target.nil?

    true
  end

  private

    def initialize(source)
      @source = source
    end

end