module Recallable
  include ActiveSupport::Concern

  def recall(user)
    case self
    when Lot
      recall_lot(user)
    when Bag
      recall_bag(user)
    else
      raise "Recall not yet implemented!"
    end
  end

  def unrecall(user)
    case self
    when Lot
      unrecall_lot(user)
    when Bag
      unrecall_bag(user)
    else
      raise "Unrecall not yet implemented!"
    end
  end

  private

    def recall_lot(user)
      history.add_line(self, self, nil, :recall, user, "Lot recalled by #{user}.")
      update(recalled: true) unless recalled?
      bags.each do |bag|
        bag.recall unless bag.recalled?
      end
      true
    rescue
      false
    end

    def unrecall_lot(user)
      history.add_line(self, self, nil, :unrecall, user, "Lot unrecalled by #{user}.")
      update(recalled: false) if recalled?
      bags.each do |bag|
        bag.unrecall if bag.recalled?
      end
      true
    rescue
      false
    end

    def recall_bag(user)
      history.add_line(self, self, nil, :recall, user, "Bag recalled by #{user}.")
      update(recalled: true) unless recalled?
      lot.recall unless lot.recalled?
      true
    rescue
      false
    end

    def unrecall_bag(user)
      history.add_line(self, self, nil, :unrecall, user, "Bag unrecalled by #{user}.")
      update(recalled: false) if recalled?
      lot.unrecall if lot.recalled?
      true
    rescue
      false
    end

end