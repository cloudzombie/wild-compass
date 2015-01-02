module Accountable
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def trims
      where(category: 'Trim')
    end

    def buds
      where(category: 'Bud')
    end

    def strains
      Strain.pluck(:name).uniq
    end

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

    def total_weight_per_strain
      0.0
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