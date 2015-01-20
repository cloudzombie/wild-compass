module Accountable
  extend ActiveSupport::Concern

  module ClassMethods
    def total_weight_per_trim
      total_weight_per_trim = 0.0

      by_trims.each do |accounted|
        total_weight_per_trim += accounted.try(:current_weight)
      end

      total_weight_per_trim
    rescue
      'ERROR'
    end

    def total_weight_per_buds
      total_weight_per_buds = 0.0

      by_buds.each do |accounted|
        total_weight_per_buds += accounted.try(:current_weight)
      end

      total_weight_per_buds
    rescue
      'ERROR'
    end

    def total_weight_per_strain(strain)
      total_weight_per_strain = 0.0

      strains(strain).each do |accounted|
        total_weight_per_strain += accounted.try(:current_weight)
      end

      total_weight_per_strain
    rescue
      'ERROR'
    end

    def total_weight
      total_weight = 0.0
      
      all.each do |accounted|
        total_weight += accounted.try(:current_weight)
      end

      total_weight
    rescue
      'ERROR'
    end

    def total_initial_weight
      total_initial_weight = 0.0
      
      all.each do |accounted|
        total_initial_weight += accounted.try(:initial_weight)
      end

      total_initial_weight
    rescue
      'ERROR'
    end
  end
end