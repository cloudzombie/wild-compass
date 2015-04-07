class Wild::Compass::Product

  MINIMUM_AVAILABLE_WEIGHT = 150.0

  class << self
    def available_brands
      Brand.joins(:lots).merge(available_lots)
    end

    def available_lots
      Lot.where(released: true).joins(:bags).merge(available_bags)
    end

    def available_bags
      Bag.where(
        current_weight: 0..Float::INFINITY,
        sent_to_lab: false,
        tested: false,
        archived: false
      )
    end

    def available?(brand)
      available(brand) >= MINIMUM_AVAILABLE_WEIGHT
    end

    def available(brand)
      brand.lots.where(released: true).sum(:current_weight)
    end

    def first_available_brand
      available_brands.first
    end

    def first_available_lot
      available_lots.first
    end

    def first_available_bag
      available_bags.first
    end

    def first_available_lot_by_brand(brand)
      available_lots.where(brand: brand).first
    end

    def first_available_bag_by_brand(brand)
      available_bags.joins(:lot).merge(Lot.where(brand: brand)).first
    end
  end
end