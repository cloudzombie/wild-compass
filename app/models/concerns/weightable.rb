module Weightable
  extend ActiveSupport::Concern
  
  ##
  # Increases current weight
  #
  def increase_current_weight
    if initial_weight.nil? && current_weight.nil?
      self.current_weight = quantity
      self.initial_weight = quantity
    else
      self.current_weight += quantity
    end
    self.quantity = 0.0
  end

  ##
  # Increases current weight
  #
  def decrease_current_weight
    self.current_weight -= quantity
    self.quantity = 0.0
  end

  included do
    attr_accessor :weight
    attr_accessor :quantity

    validates :current_weight,
               presence: true,
               allow_blank: false,
               numericality: { greater_than_or_equal_to: 0.0 }

    validates :initial_weight,
               presence: true,
               allow_blank: false,
               numericality: { greater_than_or_equal_to: 0.0 }

    validates :weight,
               presence: false,
               allow_blank: true,
               numericality: { greater_than_or_equal_to: 0.0 }
    
    validates :quantity,
               presence: false,
               allow_blank: true,
               numericality: { greater_than_or_equal_to: 0.0 }
  end
end