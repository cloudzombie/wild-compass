module Recallable
  include ActiveSupport::Concern

  def recall
    case self
    when Lot
      recall_lot
    when Bag
      recall_bag
    else
      raise "Recall not yet implemented!"
    end
  end

  def unrecall
    case self
    when Lot
      unrecall_lot
    when Bag
      unrecall_bag
    else
      raise "Unrecall not yet implemented!"
    end
  end

  private

    def recall_lot
      update(recalled: true) unless recalled?
      bags.each do |bag|
        bag.recall unless bag.recalled?
      end
      true
    rescue
      false
    end

    def unrecall_lot
      update(recalled: false) if recalled?
      bags.each do |bag|
        bag.unrecall if bag.recalled?
      end
      true
    rescue
      false
    end

    def recall_bag
      update(recalled: true) unless recalled?
      lot.recall unless lot.recalled?
      true
    rescue
      false
    end

    def unrecall_bag
      update(recalled: false) if recalled?
      lot.unrecall if lot.recalled?
      true
    rescue
      false
    end

end