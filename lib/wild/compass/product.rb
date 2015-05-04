class Wild::Compass::Product

  class ProductError < StandardError
  end

  class ProductUnavailable < ProductError
  end

  MINIMUM_AVAILABLE_WEIGHT = 150.0

  class << self
    def available_brands
      brands = Brand.joins(:lots).merge(available_lots).order(id: :asc)
      raise ProductUnavailable, "Could not find brands with available product" if brands.empty?
      brands
    end

    def available_lots
      lots = Lot.where(released: true).joins(:bags).merge(available_bags).order(id: :asc)
      raise ProductUnavailable, "Could not find lots with available product" if lots.empty?
      lots
    end

    def available_bags
      bags = Bag.where(
        current_weight: MINIMUM_AVAILABLE_WEIGHT..Float::INFINITY,
        sent_to_lab: false,
        tested: false,
        archived: false
      ).order(id: :asc)
      raise ProductUnavailable, "Could not find bags with available product" if bags.empty?
      bags
    end

    def available?(brand)
      available(brand) >= MINIMUM_AVAILABLE_WEIGHT
    end

    def available(brand)
      brand.lots.where(released: true).sum(:current_weight)
    end

    def first_available_brand
      brand = available_brands.first
      raise ProductUnavailable, "Could not find first available brand with available product" if brand.nil?
      brand
    end

    def first_available_lot
      lot = available_lots.first
      raise ProductUnavailable, "Could not find first available lot with available product" if lot.nil?
      lot
    end

    def first_available_bag
      bag = available_bags.first
      raise ProductUnavailable, "Could not find first available bag with available product" if bag.nil?
      bag
    end

    def available_lots_by_brand(brand)
      lots = available_lots.where(brand: brand)
      raise ProductUnavailable, "Could not find available lots with available product for brand #{brand}" if lots.empty?
      lots
    end

    def first_available_lot_by_brand(brand)
      lot = available_lots_by_brand(brand).first
      raise ProductUnavailable, "Could not find first available lot with available product for brand #{brand}" if lot.nil?
      lot
    end

    def available_bags_by_brand(brand)
      bags = available_bags.joins(:lot).merge(available_lots_by_brand(brand))
      raise ProductUnavailable, "Could not find bags with available product for brand #{brand}" if bags.empty?
      bags
    end

    def first_available_bag_by_brand(brand)
      bag = available_bags_by_brand(brand).first
      raise ProductUnavailable, "Could not find first available bag with available product for brand #{brand}" if bag.nil?
      bag
    end
  end
end