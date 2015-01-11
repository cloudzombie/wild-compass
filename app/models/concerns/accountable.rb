module Accountable
  extend ActiveSupport::Concern

  module ClassMethods
    def total_weight_per_trim
      total_weight_per_trim = 0.0

      trims.each do |accounted|
        total_weight_per_trim += accounted.current_weight
      end

      total_weight_per_trim
    end

    def total_weight_per_buds
      total_weight_per_buds = 0.0

      buds.each do |accounted|
        total_weight_per_buds += accounted.current_weight
      end

      total_weight_per_buds
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

    def total_initial_weight
      total_initial_weight = 0.0
      
      all.each do |accounted|
        total_initial_weight += accounted.initial_weight
      end

      total_initial_weight
    end
  end
end