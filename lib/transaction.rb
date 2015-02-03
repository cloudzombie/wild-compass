class Transaction

  def self.from(source)
    Transaction.new(source, :transaction)
  end

  def self.reweight(source)
    Transaction.new(source, :reweight)
  end



  def to(target)
    @target = target
    
    self
  end



  def take(quantity)
    @source.quantity = quantity.to_d unless @source.nil?
    @target.quantity = quantity.to_d unless @target.nil?
    
    @quantity = quantity.to_d
    
    self
  end

  def weight(quantity)
    @source.quantity = quantity unless @source.nil?  

    @quantity = quantity

    self
  end



  def by(user)
    @user = user

    self
  end

  def because(message)
    @message = message

    self
  end



  def commit
    case @mode

    when :transaction
      @source.decrease_current_weight unless @source.nil?
      @target.increase_current_weight unless @target.nil?
  
      @source.history.add_line(@source, @target, @quantity, :decrease_current_weight, @user, 'SYSTEM TRANSACTION (-)') unless @source.nil?
      @target.history.add_line(@target, @source, @quantity, :increase_current_weight, @user, 'SYSTEM TRANSACTION (+)') unless @target.nil?

    when :reweight
      @source.reweight unless @source.nil?
      @source.history.add_line(@source, @source, @quantity, :reweight, @user, @message) unless @source.nil?
    end

    true
  end

  private

    def initialize(source, mode)
      @source = source
      @mode = mode
    end

end