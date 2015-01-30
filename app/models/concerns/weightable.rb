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

    after_save :set_name

    after_initialize :set_weight
    after_initialize :set_current_weight
    after_initialize :set_initial_weight
    after_initialize :set_quantity

    before_create :allocate_initial_weight
  end

  private

    def set_name
      update(name: "#{identifier}-#{unique_identifier}") unless has_name?
    end

    def allocate_initial_weight
      if self.initial_weight == 0.0 && self.current_weight > 0.0
        self.initial_weight = self.current_weight
      end
    end

    def set_current_weight
      self.current_weight = 0.0 unless has_current_weight?
      self.current_weight = current_weight.to_d
    end

    def set_initial_weight
      self.initial_weight = 0.0 unless has_initial_weight?
      self.initial_weight = initial_weight.to_d
    end

    def set_weight
      self.weight = 0.0 unless has_weight?
      self.weight = weight.to_d
    end

    def set_quantity
      self.quantity = 0.0 unless has_quantity?
      self.quantity = quantity.to_d
    end

    def has_name?
      !name.nil?
    end

    def has_weight?
      !weight.nil?
    end

    def has_current_weight?
      !current_weight.nil?
    end

    def has_initial_weight?
      !initial_weight.nil?
    end

    def has_quantity?
      !quantity.nil?
    end

     def identifier
      self.class.name.upcase
    end

    def unique_identifier
      case self.class
      when Bag
        self.name
      else
        self.id
      end
    end
end