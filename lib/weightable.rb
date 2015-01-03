module Weightable
  extend ActiveSupport::Concern
  
  ##
  # Increases current weight
  #
  def increase_current_weight(quantity)
    update_attributes current_weight: current_weight + quantity
  end

  ##
  # Increases current weight
  #
  def decrease_current_weight(quantity)
    update_attributes current_weight: current_weight - quantity
  end

  included do
    attr_accessor :weight
    validates :current_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :initial_weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :weight, presence: false, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  end
end