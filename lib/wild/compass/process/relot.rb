class Wild::Compass::Process::Relot
  
  def initialize(lot_id)
    @previous_lot = Lot.find(lot_id)
  end

  def read_from_scale_1
    (@scale1 ||= Scale.new('localhost', 8080)).read
  end

  def read_from_scale_2
    (@scale2 ||= Scale.new('localhost', 8081)).read
  end


end