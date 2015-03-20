require 'wild/compass/math'

module Accountable
  extend ActiveSupport::Concern

  include Wild::Compass::Math



  ### Included

  included do
    before_save :update_delta if respond_to? :delta
    before_save :update_delta_old if respond_to? :delta_old
    before_save :adjust_current_weight if respond_to? :current_weight

    has_many :incoming_transactions, as: 'target', class_name: 'Transaction', dependent: :destroy
    has_many :outgoing_transactions, as: 'source', class_name: 'Transaction', dependent: :destroy
  end

  

  def transactions
    Transaction.where('(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)', id, self.class, id, self.class).uniq
  end

  def update_all_delegated_attributes!
    update_delta! if respond_to? :delta
    update_delta_old! if respond_to? :delta_old
    save
  end

  def transaction_changed
    @skip_adjust = true
    update(current_weight: incoming_weight - outgoing_weight)
    @skip_adjust = false
  end

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def outgoing_weight
    outgoing_transactions.sum(:weight)
  end

  def adjust_current_weight
    return true if current_weight_was.nil? || @skip_adjust
    if current_weight_changed?
      weight = current_weight_was.abs - current_weight.abs
      if weight < 0
        Transaction.create(
          event:  Time.now,
          source: self,
          target: Transactions::Adjustment.instance,
          weight: weight.abs
        )
      elsif weight > 0
        Transaction.create(
          event:  Time.now,
          source: Transactions::Adjustment.instance,
          target: self,
          weight: weight.abs
        )
      end
    else
      true
    end
  end



  ### Class methods

  module ClassMethods
    def total_weight_per_trim
      by_trims.sum(:current_weight)
    end

    def total_weight_per_buds
      by_buds.sum(:current_weight)
    end

    def total_weight_per_strain(strain)
      strains(strain).sum(:current_weight)
    end

    def total_weight
      all.sum(:current_weight)
    end

    def total_initial_weight
      all.sum(:initial_weight)
    end
  end

  private

    def update_delta
      if initial_weight_changed? || current_weight_changed?
        self[:delta] = initial_weight - current_weight
      end
    end

    def update_delta_old
      if initial_weight_changed? || current_weight_changed?
        previous = (history.history_lines.reweight.order(created_at: :asc))[-2]
        last = (history.history_lines.reweight.order(created_at: :asc))[-1]

        self[:delta_old] = delta(previous, last, current_weight, initial_weight)
      end
    end

    def update_delta!
      self[:delta] = initial_weight - current_weight
    end

    def update_delta_old!
      previous = (history.history_lines.reweight.order(created_at: :asc))[-2]
      last = (history.history_lines.reweight.order(created_at: :asc))[-1]
      
      self[:delta_old] = delta(previous, last, current_weight, initial_weight)
    end

end