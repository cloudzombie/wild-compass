module Quarantineable
  include ActiveSupport::Concern

  def quarantine(user)
    case self
    when Lot
      quarantine_lot(user)
    when Bag
      quarantine_bag(user)
    else
      raise "Quarantine not yet implemented!"
    end
  end

  def unquarantine(user)
    case self
    when Lot
      unquarantine_lot(user)
    when Bag
      unquarantine_bag(user)
    else
      raise "Unquarantine not yet implemented!"
    end
  end

  private
  
    def quarantine_lot(user)
      history.add_line(self, self, nil, :quarantine, user, "Lot quarantined by #{user}.")
      update(quarantined: true) unless quarantined?
      bags.each do |bag|
        bag.quarantine unless bag.quarantined?
      end
      true
    rescue
      false
    end

    def unquarantine_lot(user)
      history.add_line(self, self, nil, :unquarantine, user, "Lot unquarantined by #{user}.")
      update(quarantined: false) if quarantined?
      bags.each do |bag|
        bag.unquarantine if bag.quarantined?
      end
      true
    rescue
      false
    end

    def quarantine_bag(user)
      history.add_line(self, self, nil, :quarantine, user, "Bag quarantined by #{user}.")
      update(quarantined: true) unless quarantined?
      lot.quarantine unless lot.quarantined?
      true
    rescue
      false
    end

    def unquarantine_bag(user)
      history.add_line(self, self, nil, :unquarantine, user, "Bag unquarantined by #{user}.")
      update(quarantined: false) if quarantined?
      lot.unquarantine if lot.quarantined?
      true
    rescue
      false
    end

end