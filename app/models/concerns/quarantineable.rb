module Quarantineable
  include ActiveSupport::Concern

  def quarantine
    case self
    when Lot
      quarantine_lot
    when Bag
      quarantine_bag
    else
      raise "Quarantine not yet implemented!"
    end
  end

  def unquarantine
    case self
    when Lot
      unquarantine_lot
    when Bag
      unquarantine_bag
    else
      raise "Unquarantine not yet implemented!"
    end
  end

  private
  
    def quarantine_lot
      update(quarantined: true) unless quarantined?
      bags.each do |bag|
        bag.quarantine unless bag.quarantined?
      end
      true
    rescue
      false
    end

    def unquarantine_lot
      update(quarantined: false) if quarantined?
      bags.each do |bag|
        bag.unquarantine if bag.quarantined?
      end
      true
    rescue
      false
    end

    def quarantine_bag
      update(quarantined: true) unless quarantined?
      lot.quarantine unless lot.quarantined?
      true
    rescue
      false
    end

    def unquarantine_bag
      update(quarantined: false) if quarantined?
      lot.unquarantine if lot.quarantined?
      true
    rescue
      false
    end

end