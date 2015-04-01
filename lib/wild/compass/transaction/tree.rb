class Wild::Compass::Transaction::Tree

  attr_accessor :transactions, :source

  def initialize(source)
    self.source = source
    self.transactions = get_transactions_from_tree
  end

  def get_transactions_from_tree
    txn = []
    recursive_reverse_walk_tree(txn, source)
    recursive_forward_walk_tree(txn, source)
    txn.uniq
  end

  def recursive_reverse_walk_tree(ary, x)
    return unless x.respond_to? :incoming_transactions
    x.incoming_transactions.each do |t|
      ary << t
      recursive_reverse_walk_tree(ary, t.source)
    end
  end

  def recursive_forward_walk_tree(ary, x)
    return unless x.respond_to? :outgoing_transactions
    x.outgoing_transactions.each do |t|
      ary << t
      recursive_forward_walk_tree(ary, t.target)
    end
  end
end