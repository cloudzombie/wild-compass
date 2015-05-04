require 'wild/compass/transaction/tree'

module Accountable
  extend ActiveSupport::Concern

  include Wild::Compass::Math

  ### Included

  included do
    before_save :update_delta, if: :responds_to_delta?
    before_save :update_delta_old, if: :responds_to_delta_old?
    
    before_save :adjust_current_weight, if: :responds_to_current_weight?

    has_many :incoming_transactions, as: 'target', class_name: 'Transaction', dependent: :destroy
    has_many :outgoing_transactions, as: 'source', class_name: 'Transaction', dependent: :destroy
    
    has_many :incoming_bags, through: :incoming_transactions, source: :source, source_type: 'Bag'
    has_many :outgoing_bags, through: :outgoing_transactions, source: :target, source_type: 'Bag'
    
    has_many :incoming_jars, through: :incoming_transactions, source: :source, source_type: 'Jar'
    has_many :outgoing_jars, through: :outgoing_transactions, source: :target, source_type: 'Jar'

    has_many :incoming_containers, through: :incoming_transactions, source: :source, source_type: 'Container'
    has_many :outgoing_containers, through: :outgoing_transactions, source: :target, source_type: 'Container'

    has_many :incoming_harvests, through: :incoming_transactions, source: :source, source_type: 'Harvest'
  end

  def transactions
    Transaction.where(transactions_query, id, self.class, id, self.class).uniq
  end

  def transactions_query
    '(source_id = ? AND source_type = ?) OR (target_id = ? AND target_type = ?)'
  end

  def bags
    [ Bag.joins(:incoming_transactions).merge(transactions).uniq,
      Bag.joins(:outgoing_transactions).merge(transactions).uniq ].flatten.uniq
  end

  def containers
    [ Container.joins(:incoming_transactions).merge(transactions).uniq,
      Container.joins(:outgoing_transactions).merge(transactions).uniq ].flatten.uniq
  end

  def jars
    [ Jar.joins(:incoming_transactions).merge(transactions).uniq,
      Jar.joins(:outgoing_transactions).merge(transactions).uniq ].flatten.uniq
  end

  def harvests
    incoming_harvests.uniq
  end

  def timeline_transactions
    txn = Wild::Compass::Transaction::Tree.new(self)
    txn.transactions
  end

  def update_all_delegated_attributes!
    update_delta! if respond_to? :delta
    update_delta_old! if respond_to? :delta_old
    save
  end

  def transaction_changed
    return true unless self.respond_to?(:current_weight)
    @skip_adjust = true
    update(current_weight: incoming_weight - outgoing_weight)
    @skip_adjust = false
    true
  end

  def incoming_weight
    incoming_transactions.sum(:weight)
  end

  def outgoing_weight
    outgoing_transactions.sum(:weight)
  end

  def adjust_current_weight
    return true if current_weight_was.nil? || @skip_adjust || self.kind_of?(Lot)
    if current_weight_changed?
      weight = current_weight - current_weight_was
      Transaction.create(
        event:  Time.now,
        source: Transactions::Adjustment.instance,
        target: self,
        weight: weight
      )
    else
      true
    end
  end

  def water_loss
    Transaction.where(source: self, target: Transactions::WaterLoss.instance).sum(:weight)
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
      sum(:current_weight)
    end

    alias_method :total_current_weight, :total_weight

    def total_initial_weight
      sum(:initial_weight)
    end
  end

  private

    def responds_to_delta?
      respond_to? :delta
    end

    def responds_to_current_weight?
      respond_to? :current_weight
    end

    def responds_to_delta_old?
      respond_to? :delta_old
    end

    def update_delta
      if initial_weight_changed? || current_weight_changed?
        self[:delta] = initial_weight - current_weight
      end
    end

    def update_delta_old
      return if history.nil?
      if initial_weight_changed? || current_weight_changed?
        previous = (history.history_lines.reweight.order(created_at: :asc))[-2]
        last = (history.history_lines.reweight.order(created_at: :asc))[-1]

        self[:delta_old] = compute_delta(previous, last, current_weight, initial_weight)
      end
    end

    def update_delta!
      self[:delta] = initial_weight - current_weight
    end

    def update_delta_old!
      return if history.nil?
      previous = (history.history_lines.reweight.order(created_at: :asc))[-2]
      last = (history.history_lines.reweight.order(created_at: :asc))[-1]
      
      self[:delta_old] = compute_delta(previous, last, current_weight, initial_weight)
    end

end