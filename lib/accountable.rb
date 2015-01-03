require 'active_support/concern'

module Accountable
  extend ActiveSupport::Concern
    
  included do
    scope :trims, -> { where(category: 'Trim') }
    scope :buds, -> { where(category: 'Bud') }
    scope :strains, -> (strain = nil) { where(strain: strain) }
  end

  module ClassMethods
    def total_weight_per_trim
      total_weight_per_trim = 0.0

      trims.each do |accounted|
        total_weight_per_trim += accounted.current_weight
      end

      total_weight_per_trim
    end

    def total_weight_per_bud
      total_weight_per_bud = 0.0

      buds.each do |accounted|
        total_weight_per_bud += accounted.current_weight
      end

      total_weight_per_bud
    end

    def total_weight_per_strain(strain)
      total_weight_per_strain = 0.0

      strains(strain).each do |accounted|
        total_weight_per_strain += accounted.current_weight
      end

      total_weight_per_strain
    end

    def total_weight
      total_weight = 0.0
      
      all.each do |accounted|
        total_weight += accounted.current_weight
      end

      total_weight
    end
  end
end