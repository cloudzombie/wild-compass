class Wild::Compass::Transaction::Tree

  attr_accessor :transactions, :source

  def initialize(source)
    self.source = source
    self.transactions = get_transactions_from_tree(source)
  end

  def get_transactions_from_tree(source)
    txn = []
    reverse_map, forward_map = {}, {}
    
    recursive_reverse_walk_tree(reverse_map, source)
    recursive_forward_walk_tree(forward_map, source)
    
    txn << reverse_map.values
    txn << forward_map.values

    txn.flatten.uniq
  end

  def recursive_reverse_walk_tree(map, x)
    return unless x.respond_to? :incoming_transactions
    return if map.key? x
    
    map[x] = []
    x.incoming_transactions.each do |t|
      map[x] << t
      recursive_reverse_walk_tree(map, t.source)
    end
  end

  def recursive_forward_walk_tree(map, x)
    return unless x.respond_to? :outgoing_transactions
    return if map.key? x

    map[x] = []
    x.outgoing_transactions.each do |t|
      map[x] << t
      recursive_forward_walk_tree(map, t.target)
    end
  end
end