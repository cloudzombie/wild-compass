class Transaction < ActiveRecord::Base

  belongs_to :source, polymorphic: true
  
  belongs_to :target, polymorphic: true

  

  validates :source,  presence: true

  validates :target,  presence: true

  validates :weight,  presence: true

  validates :event,   presence: true

  

  before_validation :set_event

  after_save :transaction_changed



  def self.from(source)
    new(source: source) do |t|
      t.instance_variable_set(:@mode, :transaction)
    end
  end

  def self.reweight(source)
    new(source: source) do |t|
      t.instance_variable_set(:@mode, :reweight)
    end
  end

  def to(target)
    self.target = target
    self
  end

  def take(weight)
    self.weight = weight
    self
  end

  def amount(weight)
    self.weight = weight
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
      source.history.add_line(source, target, weight, :decrease_current_weight, @user, 'SYSTEM TRANSACTION (-)')
      target.history.add_line(target, source, weight, :increase_current_weight, @user, 'SYSTEM TRANSACTION (+)')
    when :reweight
      source.history.add_line(source, source, weight, :reweight, @user, @message)
    end

    save
  end

  private

    def set_event
      self.event = DateTime.now if event.nil?
    end
    
    def transaction_changed
      source.transaction_changed
      target.transaction_changed
    end

end
