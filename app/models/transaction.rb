class Transaction < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  
  belongs_to :target, polymorphic: true

  validates :source,  presence: true

  validates :target,  presence: true

  validates :weight,  presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  validates :event,   presence: true

  after_save :transaction_changed

  private
    
    def transaction_changed
      source.transaction_changed
      target.transaction_changed
    end

end
